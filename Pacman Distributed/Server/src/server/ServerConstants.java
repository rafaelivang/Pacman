/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package server;

/**
 *
 * @author sergiovillalobos
 */
public class ServerConstants {
    public static final String DISCOVER_MSG = "JOIN_GAME";
    
    public static final String BROADCAST_IP = "255.255.255.255";
    
    public static final int TCP_PORT = 3333;
    
    public static final int PACMAN = 1;
    public static final int GHOST_1 = 2;
    public static final int GHOST_2 = 3;
    public static final int GHOST_3 = 4;
    public static final int GHOST_4 = 5;
    
    public static final int ASSIGN_CHAR_STATE = 0;
    public static final int START_SIGNAL_STATE = 1;
    public static final int LISTENING_STATE = 2;
    public static final int WRITING_STATE = 3;
    public static final int IDLE_STATE = -1;
}
