import subprocess
import datetime

def good_morning():
    now = datetime.datetime.now()
    hour = now.hour
    today = now.strftime("%Y-%m-%d")

    if hour < 12:
        greeting = "Good morning"
    elif hour < 17:
        greeting = "Good afternoon"
    else:
        greeting = "Good evening"

    print(f"{greeting}! Launching Obsidian...")
    subprocess.Popen(["obsidian", f"obsidian://daily"])
    print( f" Opening today's note : {today}. Have a productive day!")

good_morning()
