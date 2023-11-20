
# Configuration
HassOS SSH Port 22222 Configurator requires configuration. Copy your public key into the configurator in a single line as such

```
SSHKey: "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDGTlRAfhm9BIV6l6sOubRgeCY0wRhYQVfB3QBWFl2ELpeAnTHwRYY+4pSP1Nu7FuZqAzDyZkssmFkbXHJGqi6EAnAkRLsKhzvDKo5WSXfEQdl2kSN5bgU/e37GfwqG4ChEfY56gwu+tdHtt4eIrzKpmUKqFZWJaGoeI9sHptQR9QNitEsm0krkOcK0VLFLTeau+HOO1A4plcLjBB9Y43SFjth/Ouke+DVGaBO2LYNc8U0S4EiHT6KdRXS4iIwYjXMw6SEsT7eP9IWQObQ4ZgyG0cHO/6ArxJ0fyOcAI29sLzM9466ID0mTaJWHriTRf6Lxhpdd/S30VTG0JMTdo/Fj  root@HLAB-A17"
```

(PLEASE NOTE! In recent versions of Home Assistant, you do NOT NEED TO ADD the `SSHKey:` yaml key, UNLESS you select `Edit In YAML` from the `Configuration` 3-dot menu. In other words, just paste your double-quoted SSH public key directly into the field provided. You may want to select `Edit In YAML` to validate that the final YAML passed to the add-on is as expected).

After saving, Home Assistant may change your input to look like this
![image](https://raw.githubusercontent.com/adamoutler/HassOSConfigurator/main/gitResources/configuration.png)

# Support
If problems are encountered please get all "Karen" in the foums and make sure to display attitude, because developers love that.  Alternatively, you can provide a log and tell us the problem, what you did, the model of your device, and what happened differently than what you expected.

Support is provided on the Home Assistant Community forums [here](https://community.home-assistant.io/t/add-on-hassos-ssh-port-22222-configurator/264109)

# Operation
Hit the start button and observe the logs.  Perform 2 pull-the-plug reboots after running this.  You may uninstall the Add-On when it tells you it can find I2C. 
