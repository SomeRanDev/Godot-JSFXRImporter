extends EditorImportPlugin
class_name JSFXRImporter

var editor_settings: EditorSettings;

func _get_importer_name():
	return "somerandev.jsfxr";

func _get_visible_name():
	return "JSFXR";

func _get_recognized_extensions():
	return ["jsfxr"];

func _get_save_extension():
	return "sample";

func _get_resource_type():
	return "AudioStreamWAV";

func _get_priority():
	return 1.0;

func _get_import_order():
	return 0;

func _get_import_options(path: String, preset_index: int) -> Array[Dictionary]:
	return [];

func _get_preset_count() -> int:
	return 0;

func _import(source_file, save_path, options, r_platform_variants, r_gen_files):
	var file = FileAccess.open(source_file, FileAccess.READ);
	if file == null: return FileAccess.get_open_error();

	var temp_file = "res://addons/SomeRanDev_JSFXRImporter/temp";

	var node_exe_path = editor_settings.get_setting(JSFXRImporterPlugin.NODEJS_EXE_SETTING_PATH);
	var arguments = [
		ProjectSettings.globalize_path("res://addons/SomeRanDev_JSFXRImporter/js_code/index.js"),
		ProjectSettings.globalize_path(source_file),
		ProjectSettings.globalize_path(temp_file)
	];

	var output = [];
	if OS.execute(node_exe_path, arguments, output, true, false) != 0:
		temp_file = "res://addons/SomeRanDev_JSFXRImporter/error.wav";
		print("There was an error generating the JSFXR .wav file.\nView output below:\n\n" + output[0]);

	var wav = AudioStreamWAV.load_from_file(temp_file);
	return ResourceSaver.save(wav, save_path + "." + _get_save_extension());
