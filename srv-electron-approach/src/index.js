import { app, BrowserWindow, Menu } from 'electron';
const shell = require('electron').shell

// Handle creating/removing shortcuts on Windows when installing/uninstalling.
if (require('electron-squirrel-startup')) { // eslint-disable-line global-require
  app.quit();
}

// Keep a global reference of the window object, if you don't, the window will
// be closed automatically when the JavaScript object is garbage collected.
let mainWindow;

const createWindow = () => {
  // Create the browser window.
  mainWindow = new BrowserWindow({
    width: 800,
    height: 600,
  });

  // and load the index.html of the app.
  mainWindow.loadURL(`file://${__dirname}/index.html`);

  // Open the DevTools.
  //mainWindow.webContents.openDevTools();

  // Emitted when the window is closed.
  mainWindow.on('closed', () => {
    // Dereference the window object, usually you would store windows
    // in an array if your app supports multi windows, this is the time
    // when you should delete the corresponding element.
    mainWindow = null;
  });

  var menu = Menu.buildFromTemplate([
    {
      label: 'Menu',
      submenu: [
        { label: 'Item menu 1' },
        { label: 'Item menu 2' },
        { type: 'separator' },
        {
          label: 'Exit',
          click() {
            app.quit()
          }
        }
      ]
    },
    {
      label: 'Info',
      submenu: [
        {
          label: 'Source Code',
          click() {
            shell.openExternal('https://github.com/thinn5/5WORK2019')
          }
        },
        { type: 'separator' },
        { label: 'About us',
          click() {
            const modalPath = (`file://${__dirname}/about-us.html`)
            let win = new BrowserWindow({ frame: true, alwaysOnTop: true, width: 981, height: 369 })
            win.setMenu(null)
            win.setResizable(false)
            win.on('close', function () { win = null })
            win.loadURL(modalPath)
            win.show()
          }
        }
      ]
    }
  ])
  Menu.setApplicationMenu(menu);

};

// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
// Some APIs can only be used after this event occurs.
app.on('ready', createWindow);

// Quit when all windows are closed.
app.on('window-all-closed', () => {
  // On OS X it is common for applications and their menu bar
  // to stay active until the user quits explicitly with Cmd + Q
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('activate', () => {
  // On OS X it's common to re-create a window in the app when the
  // dock icon is clicked and there are no other windows open.
  if (mainWindow === null) {
    createWindow();
  }
});

// In this file you can include the rest of your app's specific main process
// code. You can also put them in separate files and import them here.