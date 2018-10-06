function Get-PSRedfishEventSubscription
{
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory = $true)]
        [String]
        $IPAddress,

        [Parameter(Mandatory = $true)]
        [pscredential]
        $Credential
    )

    $uri = "https://${IPAddress}/redfish/v1/EventService/Subscriptions"
    $response = Invoke-RestMethod -UseBasicParsing -Uri $uri -Credential $Credential
    if ($response.Members)
    {
        foreach ($member in $response.Members.'@odata.id')
        {
            $uri = "https://${IPAddress}${member}"
            Invoke-RestMethod -Uri $uri -UseBasicParsing -Credential $Credential
        }
    }
}
