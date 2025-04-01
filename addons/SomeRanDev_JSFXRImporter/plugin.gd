@tool
extends EditorPlugin

var import_plugin;

func _enter_tree() -> void:
	remove_import_plugin_if_exists();
	import_plugin = JSFXRImporter.new();
	add_import_plugin(import_plugin);

func _exit_tree() -> void:
	remove_import_plugin_if_exists();

func remove_import_plugin_if_exists():
	if import_plugin != null:
		remove_import_plugin(import_plugin);
		import_plugin = null;
