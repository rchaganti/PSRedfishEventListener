function Send-PSRedfishTestEvent
{
    [CmdletBinding(DefaultParameterSetName = 'Target')]
    param 
    (
        [Parameter(Mandatory = $true, ParameterSetName = 'Target')]
        [String]
        $IPAddress,

        [Parameter(Mandatory = $true, ParameterSetName = 'Target')]
        [pscredential]
        $Credential,

        [Parameter(Mandatory = $true, ParameterSetName = 'Target')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Mock')]
        [String]
        $EventDestination,

        [Parameter(ParameterSetName = 'Target')]
        [Parameter(ParameterSetName = 'Mock')]
        [ValidateSet('StatusChange','ResourceUpdated','ResourceAdded','ResourceRemoved','Alert')]
        [String]
        $EventType = 'Alert',

        [Parameter(ParameterSetName = 'Target')]
        [String]
        $MessageId = 'TMP0118',

        [Parameter(ParameterSetName = 'Mock')]
        [Switch]
        $MockEvent
    )

    if ($PSCmdlet.ParameterSetName -ne 'Mock')
    {
        $uri = "https://${IPAddress}/redfish/v1/EventService/Actions/EventService.SubmitTestEvent"
        $body = @{
            Destination = $EventDestination
            EventType = $EventType
            Context = 'Root'
            Protocol = 'Redfish'
            MessageId = $MessageId
        }

        $bodyJson = $body | ConvertTo-Json

        $parameters = @{
            Method = 'POST'
            UseBasicParsing = $true
            Uri = $uri
            Credential = $Credential
            Body = $bodyJson
            ContentType= 'application/json'
        }
        Write-Verbose -Message "Invoking SubmitTestEvent method on ${IPAddress} ..."
        Invoke-RestMethod @parameters
    }
    else
    {
        Write-Verbose -Message "Sending a mock event message..."
        $id = (New-Guid).guid
        $mockMessage = @{
            '@odata.context' = '/redfish/v1/$metadata#Event.Event'
            '@odata.id' = "/redfish/v1/EventService/Events/${id}"
            '@odata.type' = '#Event.v1_1_0.Event'
            'Id' = "${id}"
            'Name' = 'Event Array'
            'Context' =  'ABCDEFGH'
            'Events' = @(
                @{
                    'EventType' = "${EventType}"
                    'EventId' = "${id}"
                    'Severity' = 'Warning'
                    'Message' = 'The LAN has been disconnected'
                    'MessageId' = 'Alert.1.0.LanDisconnect'
                    'MessageArgs' = @(
                        'EthernetInterface 1',
                        "/redfish/v1/Systems/${id}"
                    )
                    'OriginOfCondition' = @{
                        '@odata.id'= "/redfish/v1/Systems/1/EthernetInterfaces/${id}"
                    }
                    'Context' = 'ABCDEFGH'
                }
            )
        }

        $requestBody = $mockMessage | ConvertTo-Json
        Invoke-RestMethod -UseBasicParsing -Uri "https://${EventDestination}" -Method POST -Headers @{'Accept'='application/json'} -Body $requestBody -ContentType 'application/json'
    }
}
