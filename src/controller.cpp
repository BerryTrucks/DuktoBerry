/*
 * controller.cpp
 *
 *  Created on: 03/04/2014
 *      Author: laairoy
 */

#include "controller.h"
#include "protocol/platform.h"

#define NETWORK_PORT 4644

controller::controller() :
		QObject(NULL), mDestBuddy(NULL) {
	// TODO Auto-generated constructor stub
	m_buddyModel = new BuddyModel();
	mDestBuddy = new DestinationBuddy(this);
	connect(&mDuktoProtocol, SIGNAL(peerListAdded(Peer)), this,
			SLOT(peerListAdded(Peer)));

	// Periodic "hello" timer
	mPeriodicHelloTimer = new QTimer(this);
	connect(mPeriodicHelloTimer, SIGNAL(timeout()), this,
			SLOT(periodicHello()));
	mPeriodicHelloTimer->start(60000);

}

controller::~controller() {
	// TODO Auto-generated destructor stub
}

void controller::sendSomeFiles(QVariant indexPath, QStringList files) {
	if (files.count() == 0)
		return;
	QVariantMap item = indexPath.toMap();
	mDestBuddy->fillFromItem(item);
	//Send files
	QStringList toSend = files;
	startTransfer(toSend);
}

void controller::periodicHello() {
	mDuktoProtocol.sayHello(QHostAddress::Broadcast);
}

void controller::peerListAdded(Peer peer) {
	// Add user in model
	m_buddyModel->addBuddy(peer);
}

void controller::initialize() {
	// Say "hello"
	mDuktoProtocol.initialize();
	mDuktoProtocol.setPorts(NETWORK_PORT, NETWORK_PORT);
	mDuktoProtocol.sayHello(QHostAddress::Broadcast);

}

bb::cascades::GroupDataModel* controller::buddyModel() {
	return m_buddyModel;
}

bool controller::prepareStartTransfer(QString* ip, qint16* port) {
//	// Check if it's a remote file transfer
//	if (mDestBuddy->ip() == "IP") {
//
//		// Remote transfer
//		QString dest = remoteDestinationAddress();
//
//		// Check if port is specified
//		if (dest.contains(":")) {
//
//			// Port is specified or destination is malformed...
//			QRegExp rx("^(.*):([0-9]+)$");
//			if (rx.indexIn(dest) == -1) {
//
//				// Malformed destination
////				setMessagePageTitle("Send");
////				setMessagePageText(
////						"Hey, take a look at your destination, it appears to be malformed!");
////				setMessagePageBackState("send");
////				emit gotoMessagePage();
//				return false;
//			}
//
//			// Get IP (or hostname) and port
//			QStringList capt = rx.capturedTexts();
//			*ip = capt[1];
//			*port = capt[2].toInt();
//		} else {
//
//			// Port not specified, using default
//			*ip = dest;
//			*port = 0;
//		}
////		setCurrentTransferBuddy(*ip);
//	} else {
//
//		// Local transfer
//		*ip = mDestBuddy->ip();
//		*port = mDestBuddy->port();
////		setCurrentTransferBuddy(mDestBuddy->username());
//	}
//
//	// Update GUI for file transfer
////	setCurrentTransferSending(true);
////	setCurrentTransferStats("Connecting...");
////	setCurrentTransferProgress(0);
//	//    mView->win7()->setProgressState(EcWin7::Normal);
//	//    mView->win7()->setProgressValue(0, 100);
//
////	emit transferStart();
//	return true;
}

void controller::startTransfer(QStringList files) {
	// Prepare file transfer
	QString ip = mDestBuddy->ip();
	qint16 port = mDestBuddy->port();
//	if (!prepareStartTransfer(&ip, &port))
//		return;

// Start files transfer
	mDuktoProtocol.sendFile(ip, port, files);
}

void controller::startTransfer(QString text) {
	// Prepare file transfer
	QString ip = mDestBuddy->ip();
	qint16 port = mDestBuddy->port();
//	if (!prepareStartTransfer(&ip, &port))
//		return;

// Start files transfer
	mDuktoProtocol.sendText(ip, port, text);
}
