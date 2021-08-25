# html5 video encoding

Execute with:

```bash
bash path/to/encode.sh YourVideoFile.FileExtension
```

This may create these files, but the output files will not have a higher resolution than the input file, for example, a 720p input will not create a 1080p output.

```
YourVideoFile_av1_240p.webm
YourVideoFile_av1_340p.webm
YourVideoFile_av1_480p.webm
YourVideoFile_av1_720p.webm
YourVideoFile_av1_1080p.webm
YourVideoFile_av1_1440p.webm
YourVideoFile_av1_2160p.webm
YourVideoFile_h264_240p.mp4
YourVideoFile_h264_340p.mp4
YourVideoFile_h264_480p.mp4
YourVideoFile_h264_720p.mp4
YourVideoFile_h264_1080p.mp4
YourVideoFile_h264_1440p.mp4
YourVideoFile_h264_2160p.mp4
YourVideoFile_h265_240p.mp4
YourVideoFile_h265_340p.mp4
YourVideoFile_h265_480p.mp4
YourVideoFile_h265_720p.mp4
YourVideoFile_h265_1080p.mp4
YourVideoFile_h265_1440p.mp4
YourVideoFile_h265_2160p.mp4
YourVideoFile_vp9_240p.webm
YourVideoFile_vp9_340p.webm
YourVideoFile_vp9_480p.webm
YourVideoFile_vp9_720p.webm
YourVideoFile_vp9_1080p.webm
YourVideoFile_vp9_1440p.webm
YourVideoFile_vp9_2160p.webm
```

The `av1` and `h265` files should be sufficient for all modern web clients. `h265` is required for Safari.

Browser support:

- [VP9](https://caniuse.com/webm)
- [AV1](https://caniuse.com/av1)
- [H.264](https://caniuse.com/mpeg4)
- [H.265](https://caniuse.com/hevc)
- [Opus](https://caniuse.com/opus)
- [Vorbis](https://caniuse.com/ogg-vorbis)
- [AAC](https://caniuse.com/aac)

Some info on encoding:

- [VP9](https://trac.ffmpeg.org/wiki/Encode/VP9)
- [AV1](https://trac.ffmpeg.org/wiki/Encode/AV1)
- [H.264](https://trac.ffmpeg.org/wiki/Encode/H.264)
- [H.265](https://trac.ffmpeg.org/wiki/Encode/H.265)
- [Vorbis](https://trac.ffmpeg.org/wiki/TheoraVorbisEncodingGuide)
- [AAC](https://trac.ffmpeg.org/wiki/Encode/AAC)