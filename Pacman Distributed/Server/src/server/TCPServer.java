/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package server;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author sergiovillalobos
 */
public class TCPServer extends Thread {
    private boolean listenTCP = false;
    private HashMap<String,Client> clients = new HashMap<String,Client>();
    private static int playerCharacter = 1;
    private ServerUi serverUi = null;
    private boolean gameStarted = false;
    private ServerSocket serverSocket = null;
    
    public void setServerUi(ServerUi serverUi)
    {
        this.serverUi = serverUi;
    }
    
    @Override
    public void run()
    {
        try
        {
            System.out.println("Start listening TCP...");
            serverSocket = new ServerSocket(ServerConstants.TCP_PORT);
            
            while(isAcceptingConn())
            {
                Socket clientSocket = serverSocket.accept();
                clientSocket.setKeepAlive(true);
                Client client = new Client(this, clientSocket, playerCharacter);
                clients.put(client.getClientIP(), client);
                logInfo("Client " + client.getClientIP() + " connected. Assigned: " + client.getCharacter());
                playerCharacter++;
            }
        }
        catch(IOException e)
        {
            System.out.println("IO: " + e.getMessage());
        }
    }
    
    public void startGame()
    {
        if(!isGameStarted() && !clients.isEmpty())
        {
            setGameStarted(true);
            Iterator it = clients.entrySet().iterator();
            while (it.hasNext()) {
                Map.Entry pair = (Map.Entry)it.next();
                Client client = (Client) pair.getValue();
                client.startGame();
            }
            logInfo("Game started.");
        }
        else if (isGameStarted())
        {
            logInfo("Cannot start game, there is one ongoing.");
        }
        else if(clients.isEmpty())
        {
            logInfo("Cannot start game, 0 clients connected.");
        }
        else
        {
            logInfo("Cannot start game.");
        }
    }
    
    public void notifyPlayers(String msg)
    {
        Iterator it = clients.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry pair = (Map.Entry)it.next();
            Client client = (Client) pair.getValue();
            client.write(msg);
        }
    }
    
    public void closeSocket()
    {
        try {
            serverSocket.close();
        } catch (IOException ex) {
            Logger.getLogger(TCPServer.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private void logInfo(String s)
    {
        if(serverUi != null)
            serverUi.appendToLog(s);
    }
    
    private boolean isAcceptingConn()
    {
        return isListenTCP() && clients.size()<5 && !isGameStarted();
    }
    
    /**
     * @return the listenTCP
     */
    public boolean isListenTCP() {
        return listenTCP;
    }

    /**
     * @param aListenTCP the listenTCP to set
     */
    public void setListenTCP(boolean aListenTCP) {
        listenTCP = aListenTCP;
    }

    /**
     * @return the gameStarted
     */
    public boolean isGameStarted() {
        return gameStarted;
    }

    /**
     * @param gameStarted the gameStarted to set
     */
    public void setGameStarted(boolean gameStarted) {
        this.gameStarted = gameStarted;
    }
}
