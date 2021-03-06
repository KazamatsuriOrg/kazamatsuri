// # Ghost Configuration
// Setup your Ghost install for various [environments](http://support.ghost.org/config/#about-environments).

// Ghost runs in `development` mode by default. Full documentation can be found at http://support.ghost.org/config/

var path = require('path'),
    config;

config = {
  // ### Production
  // When running Ghost in the wild, use the production environment.
  // Configure your URL and mail settings here
  production: {
    url: '{% if grains.get('vagrant', False) %}http://{{ pillar[site]['ghost'].get('prefix', '') }}{{ pillar[site]['domain_local'] }}{% else %}https://{{ pillar[site]['ghost'].get('prefix', '') }}{{ pillar[site]['domain'] }}{% endif %}',
    mail: {
      from: 'ghost@{{ pillar[site]['domain'] }}',
      transport: 'SMTP',
      options: {
        host: '{{ pillar['smtp']['host'] }}',
        port: {{ pillar['smtp']['port'] }},
        auth: {
          user: '{{ pillar['smtp']['username'] }}',
          pass: '{{ pillar['smtp']['password'] }}',
        }
      }
    },
    database: {
      client: 'pg',
      connection: {
        host: '{{ salt['mine.get']('roles:database', 'private_ip_addrs', expr_form='grain').values()[0][0] }}',
        user: '{{ pillar[site]['ghost']['db_user'] }}',
        password: '{{ pillar[site]['ghost']['db_password'] }}',
        database: '{{ pillar[site]['ghost']['db_name'] }}',
      },
      debug: false
    },
    {% if pillar[site]['s3']['access_key_id'] %}
    storage: {
      active: 'ghost-s3',
      'ghost-s3': {
        accessKeyId: '{{ pillar[site]['s3']['access_key_id'] }}',
        secretAccessKey: '{{ pillar[site]['s3']['access_key'] }}',
        bucket: '{{ pillar[site]['s3']['bucket'] }}',
        region: '{{ pillar[site]['s3']['region'] }}',
        assetHost: '{{ pillar[site]['s3']['cdn'] }}/'
      }
    },
    {% endif %}
    server: {
      socket: {
        path: '/var/run/ghost/{{ site }}.sock',
        permissions: '0666',
      },
    },
  },

  // ### Development **(default)**
  development: {
      // The url to use when providing links to the site, E.g. in RSS and email.
      // Change this to your Ghost blog's published URL.
      url: 'http://localhost:2368',

      // Example mail config
      // Visit http://support.ghost.org/mail for instructions
      // ```
      //  mail: {
      //      transport: 'SMTP',
      //      options: {
      //          service: 'Mailgun',
      //          auth: {
      //              user: '', // mailgun username
      //              pass: ''  // mailgun password
      //          }
      //      }
      //  },
      // ```

      // #### Database
      // Ghost supports sqlite3 (default), MySQL & PostgreSQL
      // database: {
      //   client: 'sqlite3',
      //   connection: {
      //     filename: path.join(__dirname, '/content/data/ghost-dev.db')
      //   },
      //   debug: false
      // },
      database: {
        client: 'pg',
        connection: {
          host: '{{ salt['mine.get']('roles:database', 'private_ip_addrs', expr_form='grain').values()[0][0] }}',
          user: '{{ pillar[site]['ghost']['db_user'] }}',
          password: '{{ pillar[site]['ghost']['db_password'] }}',
          database: '{{ pillar[site]['ghost']['db_name'] }}',
        },
        debug: false
      },
      {% if pillar[site]['s3']['access_key_id'] %}
      storage: {
        active: 'ghost-s3',
        'ghost-s3': {
          accessKeyId: '{{ pillar[site]['s3']['access_key_id'] }}',
          secretAccessKey: '{{ pillar[site]['s3']['access_key'] }}',
          bucket: '{{ pillar[site]['s3']['bucket'] }}',
          region: '{{ pillar[site]['s3']['region'] }}',
          assetHost: '{{ pillar[site]['s3']['cdn'] }}/'
        }
      },
      {% endif %}
      // #### Server
      // Can be host & port (default), or socket
      server: {
        // Host to be passed to node's `net.Server#listen()`
        host: '0.0.0.0',
        // Port to be passed to node's `net.Server#listen()`, for iisnode set this to `process.env.PORT`
        port: '2368'
      },
    },

  // **Developers only need to edit below here**

  // ### Testing
  // Used when developing Ghost to run tests and check the health of Ghost
  // Uses a different port number
  testing: {
    url: 'http://127.0.0.1:2369',
    database: {
      client: 'sqlite3',
      connection: {
        filename: path.join(__dirname, '/content/data/ghost-test.db')
      }
    },
    server: {
      host: '127.0.0.1',
      port: '2369'
    },
    logging: false
  },

  // ### Testing MySQL
  // Used by Travis - Automated testing run through GitHub
  'testing-mysql': {
    url: 'http://127.0.0.1:2369',
    database: {
      client: 'mysql',
      connection: {
        host     : '127.0.0.1',
        user     : 'root',
        password : '',
        database : 'ghost_testing',
        charset  : 'utf8'
      }
    },
    server: {
      host: '127.0.0.1',
      port: '2369'
    },
    logging: false
  },

  // ### Testing pg
  // Used by Travis - Automated testing run through GitHub
  'testing-pg': {
    url: 'http://127.0.0.1:2369',
    database: {
      client: 'pg',
      connection: {
        host     : '127.0.0.1',
        user     : 'postgres',
        password : '',
        database : 'ghost_testing',
        charset  : 'utf8'
      }
    },
    server: {
      host: '127.0.0.1',
      port: '2369'
    },
    logging: false
  }
};

module.exports = config;
