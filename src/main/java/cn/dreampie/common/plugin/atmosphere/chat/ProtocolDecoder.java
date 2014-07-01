/*
 * Copyright 2014 Jeanfrancois Arcand
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
package cn.dreampie.common.plugin.atmosphere.chat;

import com.alibaba.fastjson.JSON;
import org.atmosphere.config.managed.Decoder;

/**
 * Decode a String into a {@link ChatProtocol}.
 */
public class ProtocolDecoder implements Decoder<String, ChatProtocol> {
    @Override
    public ChatProtocol decode(String s) {
        return JSON.parseObject(s, ChatProtocol.class);
    }
}
