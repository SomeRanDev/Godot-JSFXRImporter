@tool
extends EditorPlugin
class_name JSFXRImporterPlugin

const NODEJS_EXE_SETTING_PATH = "jsfxr_importer/node_js_exe_path";

var import_plugin: JSFXRImporter;
var node_exe_path: String;

func _enter_tree() -> void:
	setup_settings();
	remove_import_plugin_if_exists();

	import_plugin = JSFXRImporter.new();
	import_plugin.editor_settings = get_editor_interface().get_editor_settings();
	add_import_plugin(import_plugin);

func _exit_tree() -> void:
	remove_import_plugin_if_exists();

func remove_import_plugin_if_exists():
	if import_plugin != null:
		remove_import_plugin(import_plugin);
		import_plugin = null;

func setup_settings():
	var editor_settings: EditorSettings = get_editor_interface().get_editor_settings();
	if !editor_settings.has_setting(NODEJS_EXE_SETTING_PATH):
		editor_settings.set_setting(NODEJS_EXE_SETTING_PATH, "");
	editor_settings.set_initial_value(NODEJS_EXE_SETTING_PATH, "", false);
