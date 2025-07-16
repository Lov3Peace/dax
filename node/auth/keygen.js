import jwt from "jsonwebtoken";
import { generateKeyPairSync } from "crypto";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const { privateKey, publicKey } = generateKeyPairSync("rsa", {
    modulusLength: 2048,
    privateKeyEncoding: { type: "pkcs8", format: "pem" },
    publicKeyEncoding: { type: "spki", format: "pem" },
});

fs.writeFileSync("privateKey.pem", privateKey);
fs.writeFileSync("publicKey.pem", publicKey);

export const privKey = fs.readFileSync(path.join(__dirname, "privateKey.pem"));
export const pubKey = fs.readFileSync(path.join(__dirname, "publicKey.pem"));
