const {app, BrowserWindow, ipcMain} = require('electron');
const path = require('path');

let mainWindow;

function createWindow () {
  mainWindow = new BrowserWindow({
    width: 900,
    height: 700,
    webPreferences: {
      preload: path.join(__dirname, 'preload.js'),
      nodeIntegration: false,
      contextIsolation: true,
      enableRemoteModule: false,
      webSecurity: true,
      allowRunningInsecureContent: false
    },
    show: false // Não mostrar até estar pronto
  });

  mainWindow.loadFile('./renderer/index.html');
  
  // Mostrar janela quando pronta
  mainWindow.once('ready-to-show', () => {
    mainWindow.show();
  });
  
  // Abrir DevTools em desenvolvimento
  if (process.env.NODE_ENV === 'development') {
    mainWindow.webContents.openDevTools();
  }
  
  // Resetar variável quando janela for fechada
  mainWindow.on('closed', () => {
    mainWindow = null;
  });
  
  // Interceptar navegação para debug
  mainWindow.webContents.on('did-finish-load', () => {
    console.log('Página carregada:', mainWindow.webContents.getURL());
  });
}

// Handler para recarregar página
ipcMain.handle('reload-page', () => {
  if (mainWindow) {
    mainWindow.reload();
  }
});

// Handler para resetar aplicação
ipcMain.handle('reset-app', () => {
  if (mainWindow) {
    mainWindow.webContents.session.clearStorageData();
    mainWindow.reload();
  }
});

app.whenReady().then(createWindow);

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('activate', () => {
  if (BrowserWindow.getAllWindows().length === 0) {
    createWindow();
  }
});
