function Unregister-PSRedfishEventSubscription
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

        [Parameter()]
        [String]
        $SubscriptionId
    )

    $subscriptions = Get-PSRedfishEventSubscription -IPAddress $IPAddress -Credential $Credential
    if ($subscriptions)
    {
        if ($SubscriptionId -eq '*')
        {
            foreach ($subscription in $subscriptions)
            {
                $subscriptionUrl = "https://${IPAddress}/redfish/v1/EventService/Subscriptions/$($subscription.Id)"
                $resp = Invoke-RestMethod -Method Delete -UseBasicParsing -Uri $subscriptionUrl -Credential $Credential -Verbose
            }
        }
        else
        {        
            if ($subscriptions.Id -contains $SubscriptionId)
            {
                $subscriptionUrl = "https://${IPAddress}/redfish/v1/EventService/Subscriptions/${subscriptionId}"
                $resp = Invoke-RestMethod -Method Delete -UseBasicParsing -Uri $subscriptionUrl -Credential $Credential -Verbose
            }
            else
            {
                Write-Error -Message "No subscription exists with the Id ${SubscriptionId}."    
            }
        }
    }
    else
    {
        Write-Verbose -Message "No subscriptions exist."    
    }

    if($resp)
    {
        return $resp.'@Message.ExtendedInfo'
    }
}