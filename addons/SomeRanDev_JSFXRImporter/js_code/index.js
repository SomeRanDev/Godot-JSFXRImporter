import sfxr_module from "jsfxr";
import fs from "fs";
import { dirname } from "path";
import { fileURLToPath } from "url";

const { sfxr } = sfxr_module;

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const loadPath = process.argv[2];
const savePath = process.argv[3].trim();

let soundData;
try {
	soundData = JSON.parse(fs.readFileSync(loadPath));
} catch(e) {
	soundData = null;
}

if(soundData !== null) {
	const matches = sfxr.toWave(soundData).dataURI.match(/^data:.+\/(.+);base64,(.*)$/);
	const ext = matches[1];
	const data = matches[2];
	const buffer = Buffer.from(data, 'base64');
	fs.writeFileSync(savePath, buffer);
}
