# Stop-PSRedfishEventListener

The `Stop-PSRedfishEventListener` commands stop the event listener that was started using the `Start-PSRedfishEventListener` command either locally or on a remote system. 

This command has the following parameters.

| Parameter Name | Description                                                  | Mandatory? |
| -------------- | ------------------------------------------------------------ | ---------- |
| IPAddress      | Specifies the IPAddress to which the Redfish event listener is bound to. Default is localhost. | No         |
| Port           | Specifies the Port to which the Redfish event listener is bound to. Default is 443. | No         |

## Examples

```powershell
Stop-PSRedfishEventListener -IPAddress '172.16.102.76' -Verbose
```

The above command will stop the event listener running at 172.16.102.76 and listening on port 443.

```powershell
Stop-PSRedfishEventListener -IPAddress '172.16.102.76' -Port 9090 -Verbose
```

The above command will stop the event listener running at 172.16.102.76 and listening on port 9090.

```
Stop-PSRedfishEventListener -Verbose
```

This command will stop the event listener running on the local system and listening on port 443.