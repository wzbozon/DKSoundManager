# DKSoundManager

You don’t need to add AVFoundation to every ViewController and you don’t need to initialize AVAudioPlayer every time you want to shoot a similar sound like flip sound. This makes application faster and more organized. If you will have to change some sounds in future, you just need to update sound file name in one place.

Playing different sounds across app is simple as 

```
[[DKSoundManager sharedSoundManager]  shootSuccessSound];
[[DKSoundManager sharedSoundManager]  shootErrorSound];
[[DKSoundManager sharedSoundManager]  shootPageFlipSound];
```