console.log('ServiceWorker: File loaded.');

self.addEventListener('install', function (event) {
    console.log('ServiceWorker: Installing...');
    self.skipWaiting();
});

self.addEventListener('activate', function (event) {
    console.log('ServiceWorker: Activating...');
    event.waitUntil(clients.claim());
});

self.addEventListener('push', function (event) {
    if (event.data) {
        var data = event.data.json();
        var options = {
            body: data.body,
            icon: data.icon || 'favicon.png',
            vibrate: [100, 50, 100],
            data: {
                dateOfArrival: Date.now(),
                primaryKey: '2'
            }
        };
        event.waitUntil(
            self.registration.showNotification(data.title, options)
        );
    }
});

self.addEventListener('notificationclick', function (event) {
    event.notification.close();
    event.waitUntil(
        clients.matchAll({ type: 'window', includeUncontrolled: true }).then(function (clientList) {
            for (var i = 0; i < clientList.length; i++) {
                var client = clientList[i];
                if (client.url.includes(self.registration.scope) && 'focus' in client) {
                    return client.focus().then(() => {
                        // After focusing, send a message to the client to navigate to /random
                        client.postMessage({ type: 'NAVIGATE_TO_RANDOM' });
                    });
                }
            }
            if (clients.openWindow) {
                // If no window is open, open a new one to the random route
                return clients.openWindow('/random');
            }
        })
    );
});
