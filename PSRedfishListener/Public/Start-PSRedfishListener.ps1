function Start-PSRedfishListener
{
    [CmdletBinding()]
    param 
    (
        [Parameter()]
        [String]
        $IPAddress = '*',
    
        [Parameter()]
        [Int]
        $Port = 443,
    
        [Parameter()]
        [String]
        $LogPath = "${env:Temp}"
    )
    
    if (Get-NetTCPConnection -State Listen -LocalPort $Port -ErrorAction SilentlyContinue)
    {
        throw "SSL port ${Port} is in use. Redfish listener cannot be started."
    }   
    
    function Get-RequestBody
    {
        [CmdletBinding()]
        param
        (
            [Parameter(Mandatory = $true)]
            [String]
            $ContentType,
    
            [Parameter(Mandatory = $true)]
            [System.Text.Encoding]
            $ContentEncoding,
    
            [Parameter(Mandatory = $true)]
            [System.IO.Stream]
            $Body
        )
    
        $streamReader = [System.IO.StreamReader]::new($Body)
        $bodyContents = $StreamReader.ReadToEnd()
    
        $bodyContents = $BodyContents | ConvertFrom-Json
    
        return $bodyContents
    }   
    
    $routes = @{
        "/" = { 
                    return '<html><body>This is a Redfish EVent Listener endpoint.</body></html>'
        }
        "/end" = {             
                    $response.StatusCode = 200
                    $buffer = [System.Text.Encoding]::UTF8.GetBytes('<html><body>Shutdown Complete!</body></html>')
                    $response.ContentLength64 = $buffer.Length
                    $response.OutputStream.Write($buffer, 0, $buffer.Length)
                    break
        }
    }
        
    $url = "https://${IPAddress}:${Port}/"
    $listener = New-Object System.Net.HttpListener
    $listener.Prefixes.Add($url)
    $listener.Start()
        
    Write-Verbose -Message "Listening at $url..."
        
    while ($listener.IsListening)
    {
        $context = $listener.GetContext()
        $requestUrl = $context.Request.Url
        $response = $context.Response
        
        $localPath = $requestUrl.LocalPath
        $route = $routes.Get_Item($requestUrl.LocalPath)
        
        if ($route -eq $null)
        {
            $response.StatusCode = 404
        }
        else
        {
            if ($localPath -eq '/')
            {
                if ($context.Request.HttpMethod -eq 'POST')
                {
                    $events = Get-RequestBody -ContentType $Context.Request.ContentType -ContentEncoding $Context.Request.ContentEncoding -Body $Context.Request.InputStream
                    $eventCsv = "${LogPath}\RedfishEvents\$($events.Id).csv"
    
                    Write-Verbose -Message "Event will be written to ${eventCsv}"
        
                    if (-not (Test-Path -Path "${LogPath}\RedfishEvents"))
                    {
                        $null = New-Item -Path "${LogPath}\RedfishEvents" -ItemType Directory -Force
                    }
        
                    $csvArray = @()
                    foreach ($event in $events.Events)
                    {
                        Write-Verbose -Message "Event with ID $($event.EventID) and message $($event.Message)"
                        $csvObject = [PSCustomObject] @{
                            Context = $event.Context
                            EventId = $event.EventID
                            EventTimeStamp = $event.EventTimestamp
                            EventType = $event.EventType
                            MemberId = $event.MemberId
                            Message = $event.Message
                            MessageArgs = $($event.MessageArgs -join ',')
                            MessageId = $event.MessageId
                            OriginOfCondition = $event.OriginOfCondition.'@odata.id'
                            Severity = $event.Severity
                        }
                        $csvArray += $csvObject
                    }
                        
                    $csvArray | Export-Csv -NoTypeInformation -Path $eventCsv -Encoding utf8 -Append -Force
                    $response.StatusCode = 200
                    $buffer = [System.Text.Encoding]::UTF8.GetBytes('Event Received')
                    $response.ContentLength64 = $buffer.Length
                    $response.OutputStream.Write($buffer, 0, $buffer.Length)
                }
                else
                {
                    $content = & $route
                    $response.StatusCode = 200
                    $buffer = [System.Text.Encoding]::UTF8.GetBytes($content)
                    $response.ContentLength64 = $buffer.Length
                    $response.OutputStream.Write($buffer, 0, $buffer.Length)
                }
            }
            else
            {
                $content = & $route
            }
        }
    }
        
    $listener.Stop()
}
