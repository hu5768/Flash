package com.climbing.flash

/*import android.content.Intent
import android.os.Bundle
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts*/
import io.flutter.embedding.android.FlutterActivity
/*import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine
*/
class MainActivity : FlutterActivity() 
/*{
    private val CHANNEL = "com.example.filepicker"
    private lateinit var filePickerLauncher: ActivityResultLauncher<Intent>

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // ActivityResultLauncher 초기화
        filePickerLauncher = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
            if (result.resultCode == RESULT_OK && result.data != null) {
                val uri = result.data?.data
                // 파일 URI를 Flutter로 전달할 수 있도록 처리
                MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, CHANNEL)
                    .invokeMethod("onFilePicked", uri.toString())
            }
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Flutter에서 네이티브 코드를 호출하기 위한 MethodChannel 설정
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "openFilePicker") {
                openFilePicker()
                result.success(null) // 성공적으로 파일 탐색기를 열었다는 신호
            } else {
                result.notImplemented() // 정의되지 않은 메서드가 호출될 경우
            }
        }
    }

    // 파일 탐색기를 여는 함수
    private fun openFilePicker() {
        val intent = Intent(Intent.ACTION_OPEN_DOCUMENT).apply {
            addCategory(Intent.CATEGORY_OPENABLE)
            type = "/*" // 모든 파일을 탐색 가능하도록 설정
            putExtra(Intent.EXTRA_LOCAL_ONLY, true) // 로컬 파일만 표시
        }
        filePickerLauncher.launch(intent) // 탐색기 실행
    }
}*/