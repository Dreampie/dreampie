package cn.dreampie.common.plugin.web;

/***
 * This file is part of GNU WebSocket4J.
 * Copyright (C) 2010  Marek Aaron Sapota
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 * As a special exception, the copyright holders of this library give you
 * permission to link this library with independent modules to produce an
 * executable, regardless of the license terms of these independent modules,
 * and to copy and distribute the resulting executable under terms of your choice,
 * provided that you also meet, for each linked independent module, the terms and
 * conditions of the license of that module. An independent module is a module
 * which is not derived from or based on this library. If you modify this library,
 * you may extend this exception to your version of the library, but you are not
 * obligated to do so. If you do not wish to do so, delete this exception
 * statement from your version.
 */

import java.io.IOException;
import java.net.Socket;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

import cn.dreampie.common.plugin.web.F.*;

/**
 * A WebSocket result.
 */
public abstract class WebSocket<A> {

    /**
     * Called when the WebSocket is ready
     *
     * @param in  The Socket in.
     * @param out The Socket out.
     */
    public abstract void onReady(In<A> in, Out<A> out);

    /**
     * A WebSocket out.
     */
    public static interface Out<A> {

        /**
         * Writes a frame.
         */
        public void write(A frame);

        /**
         * Close this channel.
         */
        public void close();
    }

    /**
     * A WebSocket in.
     */
    public static class In<A> {

        /**
         * Callbacks to invoke at each frame.
         */
        public final List<Callback<A>> callbacks = new ArrayList<Callback<A>>();

        /**
         * Callbacks to invoke on close.
         */
        public final List<Callback0> closeCallbacks = new ArrayList<Callback0>();

        /**
         * Registers a message callback.
         */
        public void onMessage(Callback<A> callback) {
            callbacks.add(callback);
        }

        /**
         * Registers a close callback.
         */
        public void onClose(Callback0 callback) {
            closeCallbacks.add(callback);
        }

    }

}
