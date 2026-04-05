# Capture Snippets

Use this reference only when you need concrete implementation patterns.

## Lightweight Screenshot Helper

```csharp
var screenshotSession =
    new PlayTestUtils.ScreenshotSession(TestContext.CurrentContext.Test.Name);

yield return null;
screenshotSession.CaptureWithSegments("StateName", "VariantA");
yield return null;
```

Use when the project already has a screenshot helper like the snippet above and
you only need lightweight screenshots.

## Unity Recorder Image Sequence

```csharp
var recorderSettings =
    ScriptableObject.CreateInstance<RecorderControllerSettings>();
var recorderController = new RecorderController(recorderSettings);
var imageRecorder =
    ScriptableObject.CreateInstance<ImageRecorderSettings>();

imageRecorder.name = "Screenshot";
imageRecorder.Enabled = true;
imageRecorder.OutputFormat =
    ImageRecorderSettings.ImageRecorderOutputFormat.PNG;
imageRecorder.imageInputSettings = new GameViewInputSettings
{
    OutputWidth = Screen.width,
    OutputHeight = Screen.height,
};
imageRecorder.OutputFile = "Screencap/TestName/StateName";

recorderSettings.AddRecorderSettings(imageRecorder);
recorderSettings.SetRecordModeToSingleFrame(0);
recorderController.PrepareRecording();
recorderController.StartRecording();

yield return new WaitUntil(() => !recorderController.IsRecording());
yield return new WaitUntil(() =>
    File.Exists("Screencap/TestName/StateName.png"));
```

Use when the important contract is that the test must leave a real PNG on disk.

## Unity Recorder Movie

```csharp
var recordingSession = new PlayTestUtils.ScreenRecordingSession(
    TestContext.CurrentContext.Test.Name,
    "Gameplay",
    frameRate: 30,
    quality: PlayTestUtils.RecordingQuality.Medium);

yield return new WaitForSeconds(5f);
recordingSession.Stop();
```

Use when reviewing motion matters more than inspecting individual frames.

## Manual `RenderTexture` Capture

```csharp
var renderTexture = new RenderTexture(width, height, 24);
camera.targetTexture = renderTexture;
camera.Render();

RenderTexture.active = renderTexture;
var texture = new Texture2D(width, height, TextureFormat.RGBA32, false);
texture.ReadPixels(new Rect(0, 0, width, height), 0, 0);
texture.Apply();
File.WriteAllBytes(path, texture.EncodeToPNG());
```

Use this only when Game View capture is not actually capturing the thing you
need.
