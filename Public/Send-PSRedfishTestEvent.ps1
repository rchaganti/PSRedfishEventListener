function Send-PSRedfishTestEvent
{
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory = $true)]
        [String]
        $IPAddress,

        [Parameter(Mandatory = $true)]
        [pscredential]
        $Credential,

        [Parameter(Mandatory = $true)]
        [String]
        $EventDestination,

        [Parameter()]
        [ValidateSet('StatusChange','ResourceUpdated','ResourceAdded','ResourceRemoved','Alert')]
        [String]
        $EventType = 'Alert',

        [Parametr()]
        [String]
        $MessageId = 'TMP0118'
    )

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

    Invoke-RestMethod @parameters
}
