"use strict";

/*
 *  (c) Copyright dropsoft.org - All rights reserved
 *  Author: Erarnitox <david@erarnitox.de>
 *  
 *  License: MIT License
 *
 *  Join us: https://discord.dropsoft.org
*/

document.addEventListener('DOMContentLoaded', async function() {
    let loginBtn = document.querySelector("#login-btn");

    // check if the user has been logged in
    let loggedIn = false;
    let userName;
    let user_id;
    let avatar;

    try {
        let backend_port = 3000;
        if(window.location.protocol.startsWith("https")){
            backend_port = 3030;
        }
        
        const hostname = 'dropsoft.org';
        const response = await fetch(`${window.location.protocol}//${hostname}:${backend_port}/auth/discord/account`, {
            method: 'GET',
            mode: 'cors',
            credentials: 'include',
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json;charset=UTF-8",
            },
        });
        
        if(response.ok) {
            const user = await response.json();

            userName = user.nam;
            user_id = user.sub;
            avatar = user.avt;

            loggedIn = true;
        }
    } catch (error) {
        console.log(error.message);
    }

    if (loggedIn) {
        
        let parentNode = loginBtn.parentNode;
        loginBtn.remove();

        let userAvatarUrl = `https://cdn.discordapp.com/avatars/${user_id}/${avatar}.png`;

        let userDisplay = document.createElement('div');
        userDisplay.id = "user-profile";

        let userAvatar = document.createElement('img');
        userAvatar.src = userAvatarUrl;
        userAvatar.id = "user-avatar";

        let userNameLbl = document.createElement('b');
        userNameLbl.innerText = userName;
        userNameLbl.id = "user-name";

        userDisplay.appendChild(userAvatar);
        userDisplay.appendChild(userNameLbl);

        parentNode.appendChild(userDisplay);
    }
}, false);
