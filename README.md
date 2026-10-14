# VoiceActivityAnywhere

a vencord plugin that lets you bypass the push to talk requirement in voice channels and use voice activity instead, even if you don't have the "Use Voice Activity" permission
## how it works

discord forces push to talk when you don't have the "use voice activity" permission in a channel.
<img width="473" height="204" alt="image" src="https://github.com/user-attachments/assets/8f0e0146-293a-475f-8350-97acce382bb4" />

this is a client-side check, so the plugin patches it out. no settings, just turn it on.



## install

### easy way (windows)

1. install [git](https://git-scm.com) and [node](https://nodejs.org)
2. download [install.ps1](https://github.com/ygeneric/VoiceActivityAnywhere/blob/main/install.ps1)
3. right click `install.ps1` and pick "run with powershell"
4. restart discord and enable **VoiceActivityAnywhere** in plugin settings
5. set your input mode to voice activity

the script clones vencord to `%USERPROFILE%\Vencord`, adds the plugin, builds, and injects.

if windows blocks the script, run this in powershell from the same folder:

```
powershell -ExecutionPolicy Bypass -File your/path/to/install.ps1
```

### manual way

1. clone vencord from source and put this folder in `src/userplugins/`
2. run `pnpm install`, `pnpm build`, then `pnpm inject`
3. restart discord and enable **VoiceActivityAnywhere** in plugin settings
4. set your input mode to voice activity

## notes

- discord's code changes often, so a patch may break after an update
- use at your own risk
