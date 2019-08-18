package com.hxzy.common.shiro;

import com.hxzy.common.util.MD5Utils;
import com.hxzy.entity.User;
import com.hxzy.service.UserService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Set;


//自定义登录和认证
public class MyRealm extends AuthorizingRealm{

    private Logger logger= LogManager.getLogger(this);

    private UserService userService;

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        //得到用户
        Session session=SecurityUtils.getSubject().getSession();
        User user= (User) session.getAttribute("currentUser");
        logger.info("权限查询："+user);


        SimpleAuthorizationInfo authorizationInfo=new SimpleAuthorizationInfo();
        //查询角色
        Set<String> allRoles=this.userService.findUserOwnRoleAuthority(user.getId());
        logger.info(allRoles);

        authorizationInfo.addRoles(allRoles);

        //查询角色的菜单
        Set<String> allPermiss=this.userService.findUserOwnMenuAuthority(user.getId());
        logger.info(allPermiss);
        authorizationInfo.addStringPermissions(allPermiss);

        return authorizationInfo;
    }

    //登录
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        UsernamePasswordToken token=(UsernamePasswordToken) authenticationToken;

        String userName=token.getUsername();
        String password=new String(token.getPassword());
        //查询数据库
        User dbUser=this.userService.login(userName);

        if(dbUser==null){
            throw new UnknownAccountException("用户名或密码错误");
        }else {
            String md5Pwd= MD5Utils.MD5Encode(password,dbUser.getSalt());
            if(!md5Pwd.equalsIgnoreCase(dbUser.getPassword())){
                throw new IncorrectCredentialsException("用户名或者密码错误");
            }

            //把用户信息保存到session中
            Session session=SecurityUtils.getSubject().getSession();
            session.setAttribute("currentUser",dbUser);
        }

        return new SimpleAuthenticationInfo(dbUser,password,getName());
    }
}
