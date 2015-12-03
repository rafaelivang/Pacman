/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package server;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.io.BufferedReader;
import java.io.InputStreamReader;

/**
 *
 * @author sergiovillalobos
 */
public class ClientListener extends Thread {
    private BufferedReader in;
    private int status = ServerConstants.IDLE_STATE;
    private Client parent;
    private int count = 0;
    
    public ClientListener(Client parent, BufferedReader in)
    {
        this.parent = parent;
        this.in = in;
    }
    
    public void startGame()
    {
        setStatus(ServerConstants.LISTENING_STATE);
    }
    
    public void endGame()
    {
        
    }
    
    @Override
    public void run()
    {
        try
        {
        while(true)
        {
            switch(getStatus())
            {
                case ServerConstants.LISTENING_STATE:
                    String inputLine;
                    System.out.println("working state");
                    while((inputLine = in.readLine()) != null)
                    {
                        System.out.println(count + " Rx: " + inputLine);
                        parent.getParent().notifyPlayers(inputLine);
                        count++;
                    }
                    break;
                default:
                    break;
            }
        }
        }
        catch(Exception e)
        {
            System.out.println("ClientListener: " + e.getMessage());
        }
    }

    /**
     * @return the status
     */
    public int getStatus() {
        return status;
    }

    /**
     * @param status the state to set
     */
    public void setStatus(int status) {
        this.status = status;
    }
}
