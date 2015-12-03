/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package server;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;

/**
 *
 * @author sergiovillalobos
 */
public class Client {
    private int character;
    private Socket clientSocket;
    private TCPServer parent;
    private BufferedReader in;
    private DataOutputStream out;
    private ClientListener clientListener;
    private ClientWriter clientWriter;
    
    public Client(TCPServer parent, Socket clientSocket, int character)
    {
        try
        {
            this.parent = parent;
            this.clientSocket = clientSocket;
            in = new BufferedReader(new InputStreamReader(this.clientSocket.getInputStream()));
            out = new DataOutputStream(clientSocket.getOutputStream());
            this.character = character;
            clientListener = new ClientListener(this, in);
            clientWriter = new ClientWriter(this, out);
            initThreads();
        }
        catch(IOException e)
        {
            System.out.println("Client listener: " + e.getMessage());
        }
    }
    
    public void initThreads()
    {
        clientListener.start();
        clientWriter.start();
        clientWriter.setStatus(ServerConstants.ASSIGN_CHAR_STATE);
    }
    
    public void startClientWriter()
    {
        clientWriter.start();
    }
    
    public void startClientListener()
    {
        clientListener.start();
    }
    
    public void startGame()
    {
        clientListener.startGame();
        clientWriter.startGame();
    }
    
    public void write(String msg)
    {
        clientWriter.write(msg);
    }
    
    public String getClientIP()
    {
        return clientSocket.getRemoteSocketAddress().toString();
    }

    /**
     * @return the character
     */
    public int getCharacter() {
        return character;
    }

    /**
     * @param character the character to set
     */
    public void setCharacter(int character) {
        this.character = character;
    }

    /**
     * @return the parent
     */
    public TCPServer getParent() {
        return parent;
    }

    /**
     * @param parent the parent to set
     */
    public void setParent(TCPServer parent) {
        this.parent = parent;
    }
}
