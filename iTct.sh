#!/usr/bin/env bash

TITLECUTOFF=40

ITUNES_TRACK=$(osascript 2>/dev/null <<EOF
on appIsRunning(appName)
    tell application "System Events" to (name of processes) contains appName
end appIsRunning

if appIsRunning("Music") then
    tell application "Music" to get the name of the current track
end if
EOF
)

if [ -n "$ITUNES_TRACK" ]; then
    ITUNES_ARTIST=$(osascript 2>/dev/null <<EOF
on appIsRunning(appName)
    tell application "System Events" to (name of processes) contains appName
end appIsRunning

if appIsRunning("Music") then
    tell application "Music" to get the artist of the current track
end if
EOF
)

    echo "♫ $ITUNES_TRACK #[nobold]-#[bold] $ITUNES_ARTIST"
    exit 0
fi

# Try Spotify
SPOTIFY_TRACK=$(osascript 2>/dev/null <<EOF
on appIsRunning(appName)
    tell application "System Events" to (name of processes) contains appName
end appIsRunning

if appIsRunning("Spotify") then
    tell application "Spotify" to get the name of the current track
end if
EOF
)

if [ -n "$SPOTIFY_TRACK" ]; then
    SPOTIFY_ARTIST=$(osascript 2>/dev/null <<EOF
on appIsRunning(appName)
    tell application "System Events" to (name of processes) contains appName
end appIsRunning

if appIsRunning("Spotify") then
    tell application "Spotify" to get the artist of the current track
end if
EOF
)

    if [ ${#SPOTIFY_TRACK} -ge $TITLECUTOFF ]; then
        SPOTIFY_TRACK="${SPOTIFY_TRACK:0:$((TITLECUTOFF-3))}..."
    fi

    echo "♫ $SPOTIFY_TRACK #[nobold]-#[bold] $SPOTIFY_ARTIST"
    exit 0
fi
