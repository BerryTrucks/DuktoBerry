/*
 * controller.h
 *
 *  Created on: 03/04/2014
 *      Author: laairoy
 */

#ifndef CONTROLLER_H_
#define CONTROLLER_H_

#include <qobject.h>
#include <QVariantList>
#include "QTimer"
#include <bb/cascades/GroupDataModel>

#include "protocol/duktoprotocol.h"
#include "model/BuddyModel.h"

class UpdatesChecker;
class MiniWebServer;
class Settings;
//class DuktoWindow;
class QNetworkAccessManager;
class QNetworkReply;

class controller: public QObject {
	 Q_OBJECT
	 Q_PROPERTY(bb::cascades::GroupDataModel* buddyModel READ buddyModel NOTIFY onBuddyModelChanged FINAL)

public:
	controller();
	virtual ~controller();
	void initialize();
	bb::cascades::GroupDataModel* buddyModel();

signals:
	void onBuddyModelChanged();

public slots:
	void peerListAdded(Peer peer);
	void periodicHello();

private:
	DuktoProtocol mDuktoProtocol;
	QTimer *mPeriodicHelloTimer;
	BuddyModel * m_buddyModel;
};

#endif /* CONTROLLER_H_ */
