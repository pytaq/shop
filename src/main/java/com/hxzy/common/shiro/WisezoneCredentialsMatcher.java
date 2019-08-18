package com.hxzy.common.shiro;

import com.hxzy.common.util.MD5Utils;
import com.hxzy.entity.User;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.SimpleCredentialsMatcher;

/**
 * 重写密码验证规则
 */
public class WisezoneCredentialsMatcher extends SimpleCredentialsMatcher {

    /**
     *
     * @param token 用户登录时候的信息(输入用户名和明文密码)
     * @param info  认证信息(数据库信息)
     * @return
     */

    @Override
    public boolean doCredentialsMatch(AuthenticationToken token, AuthenticationInfo info) {
        //密码认证规则
        UsernamePasswordToken utoken = (UsernamePasswordToken) token;   //明文的用户名和密码

        //info-->SimpleAuthenticationInfo 加密密码
        //数据库里对象
        User  dbUser=(User) info.getPrincipals().getPrimaryPrincipal();

        //明文密码-->MD5密码
        String pwd=new String(utoken.getPassword());
        String md5Pwd= MD5Utils.MD5Encode(pwd,  dbUser.getSalt());

        return  this.equals(md5Pwd,  dbUser.getPassword());
    }



}
