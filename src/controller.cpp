/*
 * controller.cpp
 *
 *  Created on: 03/04/2014
 *      Author: laairoy
 */

#include "controller.h"

#include "protocol/platform.h"
#include "miniwebserver.h"

#define NETWORK_PORT 4644

controller::controller() :
        QObject(NULL), mDestBuddy(NULL), mSettings(NULL), mMiniWebServer(NULL)
{
    // TODO Auto-generated constructor stub
    m_buddyModel = new BuddyModel();
    m_recentModel = new RecentModel();

    // Destination buddy
    mDestBuddy = new DestinationBuddy(this);

    setCurrentTransferProgress(0);
    setCurrentTransferSending(false);

    // Settings
    mSettings = new Settings(this);

    // Mini web server
    mMiniWebServer = new MiniWebServer(NETWORK_PORT + 1);

    workingDir = QDir::currentPath();
    qDebug() << "controller::controller:" << workingDir;

    // Change current folder
//	QDir::setCurrent(mSettings->currentPath());

    connect(&mDuktoProtocol, SIGNAL(peerListAdded(Peer)), this, SLOT(peerListAdded(Peer)));
    connect(&mDuktoProtocol, SIGNAL(peerListRemoved(Peer)), this, SLOT(peerListRemoved(Peer)));
    connect(&mDuktoProtocol, SIGNAL(transferStatusUpdate(qint64, qint64)), this, SLOT(transferStatusUpdate(qint64, qint64)));
    connect(&mDuktoProtocol, SIGNAL(receiveFileStart(QString)), this, SLOT(receiveFileStart(QString)));
    connect(&mDuktoProtocol, SIGNAL(receiveFileComplete(QStringList*,qint64)), this, SLOT(receiveFileComplete(QStringList*,qint64)));
    connect(&mDuktoProtocol, SIGNAL(receiveFileCancelled()), this, SLOT(receiveFileCancelled()));
    connect(&mDuktoProtocol, SIGNAL(receiveTextComplete(QString*,qint64)), this, SLOT(receiveTextComplete(QString*,qint64)));
    connect(&mDuktoProtocol, SIGNAL(sendFileComplete(QStringList*)), this, SLOT(sendFileComplete(QStringList*)));
    connect(&mDuktoProtocol, SIGNAL(sendFileError(int)), this, SLOT(sendFileError(int)));
    connect(&mDuktoProtocol, SIGNAL(sendFileAborted()), this, SLOT(sendFileAborted()));

    // Periodic "hello" timer
    mPeriodicHelloTimer = new QTimer(this);
    connect(mPeriodicHelloTimer, SIGNAL(timeout()), this, SLOT(periodicHello()));
    mPeriodicHelloTimer->start(60000);

}

controller::~controller()
{
    // TODO Auto-generated destructor stub
    mDuktoProtocol.sayGoodbye();
    if (mPeriodicHelloTimer) mPeriodicHelloTimer->deleteLater();
    if (mSettings) mSettings->deleteLater();
    if (mMiniWebServer) mMiniWebServer->deleteLater();
}

void controller::sendSomeFiles(QVariant indexPath, QStringList files)
{
    if (files.count() == 0)
        return;
    QVariantMap item = indexPath.toMap();
    mDestBuddy->fillFromItem(item);
    //Send files
    QStringList toSend = files;
    startTransfer(toSend);
}

void controller::periodicHello()
{
    mDuktoProtocol.sayHello(QHostAddress::Broadcast);
}

void controller::peerListAdded(Peer peer)
{
    // Add user in model
    m_buddyModel->addBuddy(peer);
}

void controller::initialize()
{
    // Say "hello"
    mDuktoProtocol.initialize();
    mDuktoProtocol.setPorts(NETWORK_PORT, NETWORK_PORT);
    mDuktoProtocol.sayHello(QHostAddress::Broadcast);

}

bb::cascades::GroupDataModel* controller::buddyModel()
{
    return m_buddyModel;
}

bool controller::prepareStartTransfer(QString* ip, qint16* port)
{
    // Check if it's a remote file transfer
    if (mDestBuddy->ip() == "IP") {

        // Remote transfer
        QString dest = remoteDestinationAddress();

        // Check if port is specified
        if (dest.contains(":")) {

            // Port is specified or destination is malformed...
            QRegExp rx("^(.*):([0-9]+)$");
            if (rx.indexIn(dest) == -1) {

                // Malformed destination

                /*setMessagePageTitle("Send");
                 setMessagePageText(
                 "Hey, take a look at your destination, it appears to be malformed!");
                 setMessagePageBackState("send");
                 emit gotoMessagePage();*/
                QString pageTitle = "Send";
                QString pageText =
                        "Hey, take a look at your destination, it appears to be malformed!";
                emit gotoMessagePage(pageTitle, pageText);
                return false;
            }

            // Get IP (or hostname) and port
            QStringList capt = rx.capturedTexts();
            *ip = capt[1];
            *port = capt[2].toInt();
        } else {

            // Port not specified, using default
            *ip = dest;
            *port = 0;
        }
        setCurrentTransferBuddy(*ip);
    } else {

        // Local transfer
        *ip = mDestBuddy->ip();
        *port = mDestBuddy->port();
        setCurrentTransferBuddy(mDestBuddy->username());
    }

    // Update GUI for file transfer
    setCurrentTransferSending(true);
    setCurrentTransferStats("Connecting...");
    setCurrentTransferProgress(0);
//    mView->win7()->setProgressState(EcWin7::Normal);
    //    mView->win7()->setProgressValue(0, 100);

    emit transferStart();
    return true;
}

void controller::startTransfer(QStringList files)
{
    // Prepare file transfer
    QString ip = mDestBuddy->ip();
    qint16 port = mDestBuddy->port();
    //qDebug() << "controller::startTransfer:" << !prepareStartTransfer(&ip, &port);
    if (!prepareStartTransfer(&ip, &port))
        return;

    // Start files transfer
    mDuktoProtocol.sendFile(ip, port, files);
}

void controller::peerListRemoved(Peer peer)
{
    // Remove from the list
    m_buddyModel->removeBuddy(peer.address.toString());
    emit onBuddyModelChanged();
}

int controller::currentTransferProgress()
{
    return mCurrentTransferProgress;
}

void controller::setCurrentTransferProgress(int value)
{
    if (value == mCurrentTransferProgress)
        return;
    mCurrentTransferProgress = value;
    qDebug() << "controller::setCurrentTransferProgress:" << value;
    emit currentTransferProgressChanged();
}

void controller::transferStatusUpdate(qint64 total, qint64 partial)
{
    QString temp = QString::number(partial * 1.0 / 1048576, 'f', 1) + " MB of " + QString::number(total * 1.0 / 1048576, 'f', 1) + " MB";
//    qDebug() << "controller::transferStatusUpdate:" << partial;
//    qDebug() << "controller::transferStatusUpdate:" << temp;
    // Stats formatting
    if (total < 1024) {
        setCurrentTransferStats(
                QString::number(partial) + " B of " + QString::number(total) + " B");
    } else if (total < 1048576) {
        setCurrentTransferStats(
                QString::number(partial * 1.0 / 1024, 'f', 1) + " KB of "
                        + QString::number(total * 1.0 / 1024, 'f', 1) + " KB");
    } else {
        setCurrentTransferStats(
                QString::number(partial * 1.0 / 1048576, 'f', 1) + " MB of "
                        + QString::number(total * 1.0 / 1048576, 'f', 1) + " MB");}

    double percent = partial * 1.0 / total * 100;
    setCurrentTransferProgress(percent);
}

QString controller::currentTransferStats()
{
    return mCurrentTransferStats;
}

void controller::setCurrentTransferStats(QString stats)
{
    if (stats == mCurrentTransferStats)
        return;
    mCurrentTransferStats = stats;
    emit currentTransferStatsChanged();
}

void controller::setBuddyName(QString name)
{
    mSettings->saveBuddyName(name.replace(' ', ""));
    mDuktoProtocol.updateBuddyName();
    m_buddyModel->updateMeElement();
    emit buddyNameChanged();
}

QString controller::buddyName()
{
    return mSettings->buddyName();
}

void controller::setBuddyAvatar(QString avatar)
{
    mSettings->saveBuddyAvatar(avatar);
    emit buddyAvatarChanged();
}

QString controller::buddyAvatar()
{
    return mSettings->buddyAvatar();
}

void controller::setThemeColor(QString color)
{
    mSettings->saveThemeColor(color);
    emit themeColorChanged();
}

QString controller::themeColor()
{
    return mSettings->themeColor();
}

void controller::receiveFileStart(QString senderIp)
{
    // Look for the sender in the buddy list
    QString sender = m_buddyModel->buddyNameByIp(senderIp);
    if (sender == "")
        setCurrentTransferBuddy("remote sender");
    else
        setCurrentTransferBuddy(sender);

    // Update user interface
    setCurrentTransferSending(false);
    emit transferStart();
}

void controller::receiveFileComplete(QStringList* files, qint64 totalSize)
{
    // Add an entry to recent activities
    QDir d(".");
	if (files->size() == 1)
	    m_recentModel->addRecent(files->at(0), d.absoluteFilePath(files->at(0)), "file", mCurrentTransferBuddy, totalSize);
	else
	    m_recentModel->addRecent("Files and folders", d.absolutePath(), "misc", mCurrentTransferBuddy, totalSize);

    // Update GUI
//	mView->win7()->setProgressState(EcWin7::NoProgress);
//	QApplication::alert(mView, 5000);
    emit receiveCompleted();
    emit onRecentModelChanged();

    setCurrentTransferProgress(0);
}

void controller::receiveFileCancelled()
{
//	setMessagePageTitle("Error");
//	setMessagePageText("An error has occurred during the transfer... The data you received could be incomplete or broken.");
//	setMessagePageBackState("");
//	mView->win7()->setProgressState(EcWin7::Error);
    QString pageTitle = "Error";
    QString pageText = "An error has occurred during the transfer... The data you received could be incomplete or broken.";
	emit gotoMessagePage(pageTitle, pageText);
	setCurrentTransferProgress(0);
}

QString controller::currentTransferBuddy()
{
    return mCurrentTransferBuddy;
}

void controller::setCurrentTransferBuddy(QString buddy)
{
    if (buddy == mCurrentTransferBuddy)
        return;
    mCurrentTransferBuddy = buddy;
    emit currentTransferBuddyChanged();
}

QString controller::remoteDestinationAddress()
{
    return mRemoteDestinationAddress;
}

void controller::setRemoteDestinationAddress(QString address)
{
    if (address == mRemoteDestinationAddress)
        return;
    mRemoteDestinationAddress = address;
    emit remoteDestinationAddressChanged();
}

void controller::sendtext(QVariant indexPath, QString text)
{
    if (text == "")
        return;

    QVariantMap item = indexPath.toMap();
    mDestBuddy->fillFromItem(item);
    // Send text
    startTransfer(text);
}

void controller::receiveTextComplete(QString* text, qint64 totalSize)
{
//     Add an entry to recent activities
    m_recentModel->addRecent("Text snippet", *text, "text", mCurrentTransferBuddy, totalSize);

//     Update GUI
    emit receiveCompleted();
    emit onRecentModelChanged();
    setCurrentTransferProgress(0);
}

void controller::sendFileComplete(QStringList* files)
{
    // To remove warning
//    files = files;

    // Show completed message
//    setMessagePageTitle("Send");
//    setMessagePageText("Your data has been sent to your buddy!");
//    setMessagePageBackState("send");

    // Check for temporary file to delete
//    if (mScreenTempPath != "") {
//
//        QFile file(mScreenTempPath);
//        file.remove();
//        mScreenTempPath = "";
//    }

    QString pageTitle = "Send";
    QString pageText =
            "Your data has been sent to your buddy!";
    emit gotoMessagePage(pageTitle, pageText);
    setCurrentTransferProgress(0);
}

void controller::sendFileError(int code)
{
//    setMessagePageTitle("Error");
//    setMessagePageText("Sorry, an error has occurred while sending your data...\n\nError code: " + QString::number(code));
//    setMessagePageBackState("send");
//    mView->win7()->setProgressState(EcWin7::Error);

    // Check for temporary file to delete
//    if (mScreenTempPath != "") {
//
//        QFile file(mScreenTempPath);
//        file.remove();
//        mScreenTempPath = "";
//    }

    QString pageTitle = "Error";
    QString pageText = "Sorry, an error has occurred while sending your data...\n\nError code: " + QString::number(code);
    emit gotoMessagePage(pageTitle, pageText);
    setCurrentTransferProgress(0);
}

void controller::sendFileAborted()
{
    setCurrentTransferProgress(0);
}

void controller::startTransfer(QString text)
{
    // Prepare file transfer
    QString ip = mDestBuddy->ip();
    qint16 port = mDestBuddy->port();
	if (!prepareStartTransfer(&ip, &port))
		return;

// Start files transfer
    mDuktoProtocol.sendText(ip, port, text);
}

bool controller::currentTransferSending()
{
    return mCurrentTransferSending;
}

void controller::setCurrentTransferSending(bool sending)
{
    if (sending == mCurrentTransferSending)
        return;
    mCurrentTransferSending = sending;
    emit currentTransferSendingChanged();
}

void controller::abortTransfer()
{
    mDuktoProtocol.abortCurrentTransfer();
    setCurrentTransferProgress(0);
}

QString controller::copyFromClipboard()
{
    bb::system::Clipboard clipboard;
    QByteArray data = clipboard.value("text/plain");
    if (!data.isEmpty()) {
        return clipboard.value("text/plain");
    }
    return "";
}

bb::cascades::GroupDataModel* controller::recentModel()
{
    return m_recentModel;
}
