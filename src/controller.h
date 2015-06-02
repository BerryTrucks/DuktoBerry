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
#include <bb/cascades/GroupDataModel>
#include <bb/cascades/Color>
#include <bb/system/Clipboard>
#include <bb/system/InvokeManager>
#include <bb/system/InvokeRequest>
#include <bb/system/ApplicationStartupMode>
#include <bb/system/CardDoneMessage>
#include <bb/data/JsonDataAccess>
#include "QTimer"

#include "protocol/duktoprotocol.h"
#include "protocol/platform.h"
#include "destinationbuddy.h"
#include "model/BuddyModel.h"
#include "model/RecentModel.h"
#include "settings.h"

class UpdatesChecker;
class MiniWebServer;
class Settings;
//class DuktoWindow;
class QNetworkAccessManager;
class QNetworkReply;

class controller: public QObject {
	 Q_OBJECT
	 Q_PROPERTY(bb::cascades::GroupDataModel* buddyModel READ buddyModel NOTIFY onBuddyModelChanged FINAL)
	 Q_PROPERTY(bb::cascades::GroupDataModel* recentModel READ recentModel NOTIFY onRecentModelChanged FINAL)
	 Q_PROPERTY(QString currentTransferBuddy READ currentTransferBuddy NOTIFY currentTransferBuddyChanged)
	 Q_PROPERTY(int currentTransferProgress READ currentTransferProgress NOTIFY currentTransferProgressChanged)
	 Q_PROPERTY(QString currentTransferStats READ currentTransferStats NOTIFY currentTransferStatsChanged)
	 Q_PROPERTY(bool currentTransferSending READ currentTransferSending NOTIFY currentTransferSendingChanged)
	 Q_PROPERTY(QString buddyName READ buddyName WRITE setBuddyName NOTIFY buddyNameChanged)
	 Q_PROPERTY(QString buddyAvatar READ buddyAvatar WRITE setBuddyAvatar NOTIFY buddyAvatarChanged)
	 Q_PROPERTY(bb::cascades::Color themeColor READ themeColor NOTIFY themeColorChanged)
	 Q_PROPERTY(QString remoteDestinationAddress READ remoteDestinationAddress WRITE setRemoteDestinationAddress NOTIFY remoteDestinationAddressChanged)
	 Q_PROPERTY(bool showReviewOnsart READ showReviewOnsart WRITE setShowReviewOnsart NOTIFY showReviewOnsartChanged)
	 Q_PROPERTY(bool showTermsOnStart READ showTermsOnStart WRITE setShowTermsOnStart NOTIFY showTermsOnStartChanged)
	 Q_PROPERTY(bool countBuddy READ countBuddy NOTIFY countBuddyChanged)
	 Q_PROPERTY(bool countRecents READ countRecents NOTIFY countRecentsChanged)
	 Q_PROPERTY(QString downloadFolder READ downloadFolder WRITE setDownloadFolder NOTIFY downloadFolderChanged)

public:
	controller();
	virtual ~controller();
	void initialize();
	bb::cascades::GroupDataModel* buddyModel();
	bb::cascades::GroupDataModel* recentModel();
	QString currentTransferBuddy();
	void setCurrentTransferBuddy(QString buddy);
	int currentTransferProgress();
	void setCurrentTransferProgress(int value);
	QString currentTransferStats();
	void setCurrentTransferStats(QString stats);
	void setBuddyName(QString name);
	QString buddyName();
	void setBuddyAvatar(QString avatar);
	QString buddyAvatar();
	bb::cascades::Color themeColor();
	QString remoteDestinationAddress();
    void setRemoteDestinationAddress(QString address);
    bool currentTransferSending();
    void setCurrentTransferSending(bool sending);
    bool showTermsOnStart();
    void setShowTermsOnStart(bool showReview);
    bool showReviewOnsart();
    void setShowReviewOnsart(bool showReview);
    bool countBuddy();
    bool countRecents();
    QString downloadFolder();
    void setDownloadFolder(QString path);
    QString startupMode();

	// Invoked by QML
	Q_INVOKABLE
	void sendSomeFiles(QVariant indexPath, QStringList files);
	Q_INVOKABLE
	void sendtext(QVariant indexPath, QString text);
	Q_INVOKABLE
	void sendWithCard(QVariant indexPath);
	Q_INVOKABLE
    QString copyFromClipboard();
	Q_INVOKABLE
    void copyToClipboard(QString text);
	Q_INVOKABLE
    void abortTransfer();
	Q_INVOKABLE
	QString getHostName();
	Q_INVOKABLE
	void setThemeColor(QString color);
	Q_INVOKABLE
	int displaySizeWidth();
	Q_INVOKABLE
	int displaySizeHeight();
	Q_INVOKABLE
	bool sharedPermission();
	Q_INVOKABLE
	void cardDone();

signals:
	void currentTransferBuddyChanged();
	void onBuddyModelChanged();
	void onRecentModelChanged();
	void currentTransferProgressChanged();
	void currentTransferStatsChanged();
    void buddyNameChanged();
    void buddyAvatarChanged();
    void themeColorChanged();
    void receiveCompleted();
    void transferStart();
    void gotoMessagePage(QString pageTitle, QString pageText);
    void remoteDestinationAddressChanged();
    void currentTransferSendingChanged();
    void showTermsOnStartChanged();
    void showReviewOnsartChanged();
    void countBuddyChanged();
    void countRecentsChanged();
    void downloadFolderChanged();

public slots:
	void peerListAdded(Peer peer);
	void peerListRemoved(Peer peer);
	void periodicHello();
	void transferStatusUpdate(qint64 total, qint64 partial);
	void receiveFileStart(QString senderIp);
	void receiveFileComplete(QStringList *files, qint64 totalSize);
	void receiveFileCancelled();
    void receiveTextComplete(QString *text, qint64 totalSize);
    void sendFileComplete(QStringList *files);
    void sendFileError(int code);
    void sendFileAborted();
    void aboutToQuit();
    void handleInvoke(const bb::system::InvokeRequest& request);

private:
    uint convertThemeColor(QString color);
    bool prepareStartTransfer(QString *ip, qint16 *port);
    void startTransfer(QStringList files);
    void startTransfer(QString text);
	DuktoProtocol m_duktoProtocol;
	BuddyModel* m_buddyModel;
	RecentModel* m_recentModel;
	QTimer* m_periodicHelloTimer;
	DestinationBuddy* m_destBuddy;
	QString m_currentTransferBuddy;
	QString m_currentTransferStats;
	int m_currentTransferProgress;
	QString m_workingDir;
	Settings* m_settings;
	MiniWebServer* m_miniWebServer;
	QString m_remoteDestinationAddress;
	bool m_currentTransferSending;
	int m_countBuddy;
	int m_countRecents;
	bb::cascades::Color m_themeColor;
	bb::system::InvokeManager *m_InvokeManager;
	QVariantMap m_request;
};

#endif /* CONTROLLER_H_ */
