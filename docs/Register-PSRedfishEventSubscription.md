# Register-PSRedfishEventSubscription

This command registers a redfish device with an event listener. A given redfish can send events to multiple event listeners.

This command has the following parameters.

| Parameter Name   | Description                                                  | Mandatory? |
| ---------------- | ------------------------------------------------------------ | ---------- |
| EventDestination | Specifies the full URI of the HTTPS event listener.          | Yes        |
| IPAddress        | Specifies the IP address of the Redfish device.              | Yes        |
| Credential       | Specifies the credentials to authenticate to the Redfish device. | Yes        |
| EventType        | Specifies the type of events that will be submitted to the event listener. Allowed values are StatusChange, ResourceUpdated , ResourceAdded, ResourceRemoved, and Alert. Default is all event types. | No         |

## Examples

```powershell
Register-PSRedfishEventSubscription -EventDestination https://172.16.102.76 -IPAddress 172.16.100.21 -Credential $credential
```

The above command will register (create an event subscription) redfish device 172.16.100.21 to send all event types to listener at https://172.16.102.76. 

```powershell
Register-PSRedfishEventSubscription -EventDestination https://172.16.103.76 -IPAddress 172.16.100.21 -Credential $credential -EventType 'ResourceAdded', 'ResourceRemoved'
```

The above command will register (create an event subscription) redfish device 172.16.100.21 to send ResourceAdded and ResourceRemoved event types to listener at https://172.16.102.76. 

