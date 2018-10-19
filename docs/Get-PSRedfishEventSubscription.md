# Get-PSRedfishEventSubscription

This command gets all the event subscriptions from a Redfish device.

This command has the following parameters.

| Parameter Name | Description                                                  | Mandatory? |
| -------------- | ------------------------------------------------------------ | ---------- |
| IPAddress      | Specifies the IP address of the Redfish device.              | Yes        |
| Credential     | Specifies the credentials to authenticate with the Redfish device. | Yes        |

## Examples

```powershell
Get-PSRedfishEventSubscription -IPAddress 172.16.100.21 -Credential $credential -Verbose
```

The above command will get a list of event subscriptions from the Redfish device 172.16.100.21.

