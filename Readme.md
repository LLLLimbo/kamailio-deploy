# Kamailio docker compose

> Two SIP users are pre-configured
> 
> tommy/123456
> 
> john/123456

## Steps
1. `git clone https://github.com/LLLLimbo/kamailio-deploy`
2. `cd kamailio-deploy`
3. Update `DBURL` in `etc/kamailio/kamailio.cfg`(line 6) and `DBHOST` in `etc/kamailio/kamctlrc`(line 21) according to your own situation
4. Update listen sockets in `etc/kamailio/kamailio.cfg`(line 202&203) with your public addreess
5. `docker-compose up`
6. Call testing with pre-configured SIP users

