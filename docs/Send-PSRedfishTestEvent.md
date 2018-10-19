# Send-PSRedfishTestEvent

As per the Redfish eventing specification, each Redfish device should support submitting a test event to the listener for testing purposes. This is generally used for validation purposes that the Redfish device can indeed send the events to configured destination and the listener can process the received event messages as desired.

This command invokes the `SubmitTestEvent` method of the event service.

This command has the following parameters.

| Parameter Name   | Description                                                  | Mandatory? |
| ---------------- | ------------------------------------------------------------ | ---------- |
| IPAddress        | Specifies the IP address of the Redfish device from which the test event must be sent. | Yes        |
| Credential       | Specifies the credentials to authenticate with the Redfish device. | Yes        |
| EventDestination | Specifies the full URI to the event listener.                | Yes        |
| EventType        | Specifies the type of even to be submitted. Allowed values are StatusChange, ResourceUpdated, ResourceAdded, ResourceRemoved, and Alert. Default is Alert. | No         |
| MessageId        | Specifies the MessageId that should be submitted as a part of the test event. This must be related to the EventType. Default is TMP0118. | No         |
| MockEvent        | Specifies that the event submitted to the listener should be a mock event and not from a real Redfish device. This is a switch parameter and when used only `EventDestination` parameter is mandatory. | No         |

## Examples

```powershell
Send-PSRedfishTestEvent -IPAddress 172.16.100.21 -Credential $credential -EventDestination https://172.16.102.76 -Verbose
```

The above command will submit a test event from Redfish device with an IP address 172.16.100.21 to the event listener at 172.16.102.76. The event type and message ID will be set to the defaults defined by the function.

```powershell
Send-PSRedfishTestEvent -MockEvent -EventDestination https://172.16.102.76 -Verbose
```

The above command will submit a mock event to the event listener at https://172.16.102.76. This does not require a Redfish device.

