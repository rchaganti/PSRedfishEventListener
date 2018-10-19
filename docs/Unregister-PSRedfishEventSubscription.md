# Unregister-PSRedfishEventSubscription

This command will remove an event subscription from the Redfish device.

This command has the following parameters.

| Parameter Name | Description                                                  | Mandatory? |
| -------------- | ------------------------------------------------------------ | ---------- |
| IPAddress      | Specifies the IP address of the Redfish device for which the subscription needs to be removed or unregistered. | Yes        |
| Credential     | Specifies the credentials to authenticate to the Redfish device. | Yes        |
| SubscriptionId | Specifies the GUID of subscription that needs to removed or unregistered. Default value is * which means that all event subscriptions will be removed. To get the subscription Id, use the `Get-PSRedfishEventSubscription` command. | No         |

## Examples

```powershell
Unregister-PSRedfishEventSubscription -IPAddress 172.16.100.21 -Credential $credential -Verbose
```

The above command will remove all event subscription from the Redfish device 172.16.100.21.

```powershell
$subscription = Get-PSRedfishEventSubscription -IPAddress 172.16.100.21 -Credential $credential -Verbose

Unregister-PSRedfishEventSubscription -IPAddress 172.16.100.21 -Credential $credential -SubscriptionId $subscription.Id -Verbose
```

The above command will remove the event subscription represented by `$subscription.Id` from the redfish device 172.16.100.21.

