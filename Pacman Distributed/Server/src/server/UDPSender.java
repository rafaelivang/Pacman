/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package server;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.MulticastSocket;
import java.net.SocketException;

/**
 *
 * @author sergiovillalobos
 */
public class UDPSender extends Thread {
    private boolean keepSending = false;
    
    @Override
    public void run()
    {
        while(keepSending)
        {
            //sendMulticast();
            sendBroadcast();
        }
    }
    
    public void sendBroadcast()
    {
        DatagramSocket aSocket = null;
            try {
                aSocket = new DatagramSocket();  
                byte[] m = new byte[16];
                String peticion = ServerConstants.DISCOVER_MSG;
                m = peticion.getBytes();
                //InetAddress aHost = InetAddress.getByName(ServerConstants.BROADCAST_IP);
                InetAddress aHost = InetAddress.getByName("192.168.0.255");
                int serverPort = 2222;		                                                 
                DatagramPacket request = new DatagramPacket(m,  peticion.length(), aHost, serverPort);
                aSocket.setBroadcast(true);
                aSocket.send(request);	
                aSocket.setBroadcast(false);
                Thread.sleep(200);    
            }catch (SocketException e){System.out.println("Socket: " + e.getMessage());
            }catch (IOException e){System.out.println("IO: " + e.getMessage());
            }catch (InterruptedException e) {System.out.println("IE: " + e.getMessage());}
            finally {if(aSocket != null) aSocket.close();}
    }
    
    public void sendMulticast()
    {
        //DatagramSocket aSocket = null;
        MulticastSocket aSocket = null;
            try {
                //aSocket = new DatagramSocket();  
                aSocket = new MulticastSocket();
                byte[] m = new byte[16];
                String peticion = ServerConstants.DISCOVER_MSG;
                m = peticion.getBytes();
                //byte[] ipAddr = new byte[]{(byte)224, 0, 0, 1};
                //InetAddress aHost = InetAddress.getByAddress(ipAddr);
                //InetAddress aHost = InetAddress.getByName("224.0.0.1");
                InetAddress aHost = InetAddress.getByName("228.192.1.1");
                //aSocket.joinGroup(aHost);
                int serverPort = 2222;		                                                 
                DatagramPacket request = new DatagramPacket(m,  peticion.length(), aHost, serverPort);
                aSocket.send(request);			                        	
                Thread.sleep(200);    
            }catch (SocketException e){System.out.println("Socket: " + e.getMessage());
            }catch (IOException e){System.out.println("IO: " + e.getMessage());
            }catch (InterruptedException e) {System.out.println("IE: " + e.getMessage());}
            finally {if(aSocket != null) aSocket.close();}
    }

    /**
     * @return the keepSending
     */
    public boolean isKeepSending() {
        return keepSending;
    }

    /**
     * @param keepSending the keepSending to set
     */
    public void setKeepSending(boolean keepSending) {
        this.keepSending = keepSending;
    }
}
