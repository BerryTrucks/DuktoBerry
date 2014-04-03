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
		QObject(NULL) {
	// TODO Auto-generated constructor stub
	m_buddyModel = new BuddyModel();
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

void controller::periodicHello() {
	 mDuktoProtocol.sayHello(QHostAddress::Broadcast);
}


void controller::peerListAdded(Peer peer) {
	qDebug() << "ApplicationUI::peerListAdded:" << peer.name;
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
