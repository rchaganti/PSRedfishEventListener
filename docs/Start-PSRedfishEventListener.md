# Start-PSRedfishEventListener

The `Start-PSRedfishListener` command starts the Redfish event listener (HTTPS) on the local host. This HTTPS listener requires an SSL certificate binding and it needs to be done as a prerequisite and can be performed using the `Add-PSRedfishListenerHttpsBinding` command.

This commands has the following parameters.

| Parameter Name | Description                                                  | Mandatory? |
| -------------- | ------------------------------------------------------------ | ---------- |
| IPAddress      | Specifies the IPAddress to which the HTTPS listener should be bound to. Default is * which means the listener will be bound all local IP addresses. | No         |
| Port           | Specifies the Port to use for the HTTPS listener binding. Default is 443. | No         |
| LogPath        | Specifies the path where the received event messages will be stored as CSV file. Default is `$env:Temp\RedfishEvents`. | No         |

## Examples

```powershell
Start-PSRedfishEventListener -IPAddress 172.16.102.76 -Port 9090 -LogPath C:\RedfishEvents
```

The above command will start new event listener that is bound to a specific IP address on the local host and to port 9090. The log path will be set to C:\RedfishEvents.

```powershell
Start-PSRedfishEventListener -Verbose
```

The above command will start a new event listener with all defaults as defined in the function definition.