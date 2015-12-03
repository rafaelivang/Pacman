package server;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.HashMap;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author mdealba
 */
public class Server {
    private static UDPSender udpSender;
    private TCPServer tcpServer;
    private ServerUi serverUi;
    
    public Server()
    {
        tcpServer = new TCPServer();
        tcpServer.setListenTCP(true);
        tcpServer.start();
    }
    
    public Server(ServerUi serverUi)
    {
        this();
        this.serverUi = serverUi;
        tcpServer.setServerUi(this.serverUi);
    }
    
    public static void startFindClients()
    {
        udpSender = new UDPSender();
        udpSender.setKeepSending(true);
        udpSender.start();
    }
    
    public static void stopFindClients()
    {
        udpSender.setKeepSending(false);
    }
    
    public void startGame()
    {
        tcpServer.startGame();
    }
    
    public void restart()
    {
        tcpServer.closeSocket();
    }
}