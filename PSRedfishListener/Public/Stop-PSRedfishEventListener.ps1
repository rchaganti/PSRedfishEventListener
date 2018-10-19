function Stop-PSRedfishEventListener
{
    [CmdletBinding()]
    param 
    (
        [Parameter()]
        [String]
        $IPAddress = 'localhost',

        [Parameter()]
        [Int]
        $Port = 443
    )

    $resp = Invoke-WebRequest -UseBasicParsing -Uri "https://${IPAddress}:${Port}/end" -ErrorAction SilentlyContinue
    if ($resp)
    {
        Write-Verbose -Message 'Event Listener stopped!'
    }
    else
    {
        Write-Error -Message 'Event listener was either not found or not stopped successfully.'    
    }
}
