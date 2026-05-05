# Multitrack Player

https://dhulme.uk/multitrack-player/

A multitrack audio file player for the browser.

Built using Vue, the Vuetify UI framework and peaks.js audio waveform library.

## Current features
🎚️ Unlimited number of audio tracks  
🕰️ Metronome/click  
🎛️ Customizable panning of click/tracks  
🔇 Solo/mute for all tracks  
🔊 Individual track and master gain control  
🎹 Customisable MIDI and keyboard control  

![Screenshot](./screenshot.png)

## Local development setup

### Compiles and hot-reloads for development
`npm start` or `npm run serve`

### Compiles and minifies for production
`npm run build`

## Docker development

### Start the hot-reload dev server
`docker compose up --build app`

The app will be available at `http://localhost:8080`.

The Compose setup bind-mounts the repository into the container and keeps `node_modules` in a named volume so file watching and dependency installs stay stable during development.

### Start the production image
`docker compose --profile prod up --build app-prod`

The production image serves the built app from Nginx at `http://localhost:8081/multitrack-player/`.
