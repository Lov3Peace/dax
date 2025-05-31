import winston from "winston";

export const infoLog = winston.createLogger({
    level: "info",
    format: winston.format.json(),
    transports: [
        new winston.transports.File({ filename: 'logs/info.log' })
    ]
});

export const errorLog = winston.createLogger({
    level: "error",
    format: winston.format.json(),
    transports: [
        new winston.transports.File({ filename: 'logs/error.log' })
    ]
});