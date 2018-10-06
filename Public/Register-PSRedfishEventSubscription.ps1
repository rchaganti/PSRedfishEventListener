function Register-PSRedfishEventSubscription
{
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory = $true)]
        [String]
        $EventDestination,

        [Parameter(Mandatory = $true)]
        [String]
        $IPAddress,

        [Parameter(Mandatory =  $true)]
        [pscredential]
        $Credential,

        [Parameter()]
        [ValidateSet('StatusChange','ResourceUpdated','ResourceAdded','ResourceRemoved','Alert')]
        [String[]]
        $EventType = @('StatusChange','ResourceUpdated','ResourceAdded','ResourceRemoved','Alert')
    )  

    $body = @{
        Destination = $EventDestination
        EventTypes = $EventType
        ContextDetail = 'Public'
        Protocol = 'Redfish'
    }
    
    $bodyJson = $body | ConvertTo-Json

    $postParameters = @{
        Method = 'POST'
        UseBasicParsing = $true
        ContentType = 'application/json'
        Credential = $Credential
        Uri = "https://${IPAddress}/redfish/v1/EventService/Subscriptions"
        Body = $bodyJson
    }

    Invoke-RestMethod @postParameters -Verbose
}
