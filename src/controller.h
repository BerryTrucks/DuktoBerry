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
#include "destinationbuddy.h"
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
	 Q_PROPERTY(int currentTransferProgress READ currentTransferProgress NOTIFY currentTransferProgressChanged)
	 Q_PROPERTY(QString currentTransferStats READ currentTransferStats NOTIFY currentTransferStatsChanged)

public:
	controller();
	virtual ~controller();
	void initialize();
	bb::cascades::GroupDataModel* buddyModel();
	int currentTransferProgress();
	void setCurrentTransferProgress(int value);
	QString currentTransferStats();
	void setCurrentTransferStats(QString stats);

	// Invoked by QML
	Q_INVOKABLE
	void sendSomeFiles(QVariant indexPath, QStringList files);

signals:
	void onBuddyModelChanged();
	void currentTransferProgressChanged();
	void currentTransferStatsChanged();

public slots:
	void peerListAdded(Peer peer);
	void peerListRemoved(Peer peer);
	void periodicHello();
	void transferStatusUpdate(qint64 total, qint64 partial);

private:
	DuktoProtocol mDuktoProtocol;
	QTimer *mPeriodicHelloTimer;
	BuddyModel * m_buddyModel;
	DestinationBuddy *mDestBuddy;
	QString mCurrentTransferStats;
	int mCurrentTransferProgress;
    bool prepareStartTransfer(QString *ip, qint16 *port);
    void startTransfer(QStringList files);
    void startTransfer(QString text);
	QString workingDir;
};

#endif /* CONTROLLER_H_ */
