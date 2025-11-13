import { cpSync, existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const projectRoot = resolve(__dirname, '..');
const sourceFile = resolve(projectRoot, 'index.tsx');
const distDir = resolve(projectRoot, 'dist');
const publicDir = resolve(projectRoot, 'public');

const source = readFileSync(sourceFile, 'utf8');
const match = source.match(/String\.raw`([\s\S]*?)` as const;/);

if (!match) {
  throw new Error('htmlDocument 템플릿 리터럴을 찾을 수 없습니다.');
}

const rawHtml = match[1];

const html = rawHtml
  .replace(/\\`/g, '`')
  .replace(/\\\\/g, '\\')
  .replace(/\\\[/g, '[')
  .replace(/\\\]/g, ']')
  .replace(/\\</g, '<')
  .replace(/\\>/g, '>')
  .replace(/\\;/g, ';');

mkdirSync(distDir, { recursive: true });
writeFileSync(resolve(distDir, 'index.html'), html, 'utf8');

if (existsSync(publicDir)) {
  cpSync(publicDir, distDir, { recursive: true });
}

console.log('✅ dist/index.html 생성 완료');
if (existsSync(publicDir)) {
  console.log('✅ public 폴더를 dist/에 복사했습니다.');
}

