import winston from "winston";
export const infoLog = winston.createLogger({
  level: "info",
  format: winston.format.combine(
    winston.format.timestamp({ format: "YYYY-MM-DD HH:mm:ss" }),
    winston.format.json(),
  ),
  transports: [new winston.transports.File({ filename: "logs/info.log" })],
});

export const errorLog = winston.createLogger({
  level: "error",
  format: winston.format.combine(
    winston.format.timestamp({ format: "YYYY-MM-DD HH:mm:ss" }),
    winston.format.json(),
  ),
  transports: [new winston.transports.File({ filename: "logs/error.log" })],
});

