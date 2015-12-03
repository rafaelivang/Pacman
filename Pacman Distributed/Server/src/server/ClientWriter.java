/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package server;

import java.io.DataOutputStream;

/**
 *
 * @author sergiovillalobos
 */
public class ClientWriter extends Thread{
    private Client parent;
    private DataOutputStream out;
    private int status = ServerConstants.IDLE_STATE;
    private String msg = null;
    
    public ClientWriter(Client parent, DataOutputStream out)
    {
        this.parent = parent;
        this.out = out;
    }
    
    public void sendCharacter()
    {
        status = ServerConstants.ASSIGN_CHAR_STATE;
    }
    
    public void startGame()
    {
        status = ServerConstants.START_SIGNAL_STATE;
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
                case ServerConstants.ASSIGN_CHAR_STATE:
                    System.out.println("Send character");
                    out.writeBytes("C"+parent.getCharacter()+"\n");
                    setStatus(ServerConstants.IDLE_STATE);
                    break;
                case ServerConstants.START_SIGNAL_STATE:
                    out.writeBytes("S"+parent.getCharacter()+"\n");
                    setStatus(ServerConstants.IDLE_STATE);
                    break;
                case ServerConstants.WRITING_STATE:
                    if( getMsg() != null )
                    {
                        out.writeBytes(getMsg()+"\n");
                        System.out.println("Tx: " + getMsg());
                        setMsg(null);
                    }
                    setStatus(ServerConstants.IDLE_STATE);
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
    
    public void write(String msg)
    {
        this.msg = msg;
        status = ServerConstants.WRITING_STATE;
    }

    /**
     * @return the status
     */
    public int getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(int status) {
        this.status = status;
    }

    /**
     * @return the msg
     */
    public String getMsg() {
        return msg;
    }

    /**
     * @param msg the msg to set
     */
    public void setMsg(String msg) {
        this.msg = msg;
    }
}
