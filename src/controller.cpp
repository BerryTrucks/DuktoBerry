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
        QObject(NULL), m_destBuddy(NULL), m_settings(NULL), m_miniWebServer(NULL)
{
    // TODO Auto-generated constructor stub
    m_buddyModel = new BuddyModel();
    m_recentModel = new RecentModel();

    // Destination buddy
    m_destBuddy = new DestinationBuddy(this);

    setCurrentTransferProgress(0);
    setCurrentTransferSending(false);

    // Settings
    m_settings = new Settings(this);

    // Mini web server
    m_miniWebServer = new MiniWebServer(NETWORK_PORT + 1);

    m_workingDir = QDir::currentPath();
    qDebug() << "controller::controller:" << m_workingDir;

    // Change current folder
//	QDir::setCurrent(mSettings->currentPath());

    connect(&m_duktoProtocol, SIGNAL(peerListAdded(Peer)), this, SLOT(peerListAdded(Peer)));
    connect(&m_duktoProtocol, SIGNAL(peerListRemoved(Peer)), this, SLOT(peerListRemoved(Peer)));
    connect(&m_duktoProtocol, SIGNAL(transferStatusUpdate(qint64, qint64)), this,
            SLOT(transferStatusUpdate(qint64, qint64)));
    connect(&m_duktoProtocol, SIGNAL(receiveFileStart(QString)), this,
            SLOT(receiveFileStart(QString)));
    connect(&m_duktoProtocol, SIGNAL(receiveFileComplete(QStringList*,qint64)), this,
            SLOT(receiveFileComplete(QStringList*,qint64)));
    connect(&m_duktoProtocol, SIGNAL(receiveFileCancelled()), this, SLOT(receiveFileCancelled()));
    connect(&m_duktoProtocol, SIGNAL(receiveTextComplete(QString*,qint64)), this,
            SLOT(receiveTextComplete(QString*,qint64)));
    connect(&m_duktoProtocol, SIGNAL(sendFileComplete(QStringList*)), this,
            SLOT(sendFileComplete(QStringList*)));
    connect(&m_duktoProtocol, SIGNAL(sendFileError(int)), this, SLOT(sendFileError(int)));
    connect(&m_duktoProtocol, SIGNAL(sendFileAborted()), this, SLOT(sendFileAborted()));

    // Periodic "hello" timer
    m_periodicHelloTimer = new QTimer(this);
    connect(m_periodicHelloTimer, SIGNAL(timeout()), this, SLOT(periodicHello()));
    m_periodicHelloTimer->start(60000);

}

controller::~controller()
{
    m_duktoProtocol.sayGoodbye();
    if (m_periodicHelloTimer)
        m_periodicHelloTimer->deleteLater();
    if (m_settings)
        m_settings->deleteLater();
    if (m_miniWebServer)
        m_miniWebServer->deleteLater();
    qDebug() << "controller::~controller:" << "sayGoodbye";
}

void controller::sendSomeFiles(QVariant indexPath, QStringList files)
{
    if (files.count() == 0)
        return;
    QVariantMap item = indexPath.toMap();
    m_destBuddy->fillFromItem(item);
    //Send files
    QStringList toSend = files;
    startTransfer(toSend);
}

void controller::periodicHello()
{
    m_duktoProtocol.sayHello(QHostAddress::Broadcast);
}

void controller::peerListAdded(Peer peer)
{
    // Add user in model
    m_buddyModel->addBuddy(peer);
}

void controller::initialize()
{
    // Say "hello"
    m_duktoProtocol.initialize();
    m_duktoProtocol.setPorts(NETWORK_PORT, NETWORK_PORT);
    m_duktoProtocol.sayHello(QHostAddress::Broadcast);

}

bb::cascades::GroupDataModel* controller::buddyModel()
{
    return m_buddyModel;
}

bool controller::prepareStartTransfer(QString* ip, qint16* port)
{
    // Check if it's a remote file transfer
    if (m_destBuddy->ip() == "IP") {

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
        *ip = m_destBuddy->ip();
        *port = m_destBuddy->port();
        setCurrentTransferBuddy(m_destBuddy->username());
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
    QString ip = m_destBuddy->ip();
    qint16 port = m_destBuddy->port();
    //qDebug() << "controller::startTransfer:" << !prepareStartTransfer(&ip, &port);
    if (!prepareStartTransfer(&ip, &port))
        return;

    // Start files transfer
    m_duktoProtocol.sendFile(ip, port, files);
}

void controller::peerListRemoved(Peer peer)
{
    // Remove from the list
    m_buddyModel->removeBuddy(peer.address.toString());
    emit onBuddyModelChanged();
}

int controller::currentTransferProgress()
{
    return m_currentTransferProgress;
}

void controller::setCurrentTransferProgress(int value)
{
    if (value == m_currentTransferProgress)
        return;
    m_currentTransferProgress = value;
    qDebug() << "controller::setCurrentTransferProgress:" << value;
    emit currentTransferProgressChanged();
}

void controller::transferStatusUpdate(qint64 total, qint64 partial)
{
    QString temp = QString::number(partial * 1.0 / 1048576, 'f', 1) + " MB of "
            + QString::number(total * 1.0 / 1048576, 'f', 1) + " MB";
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
                        + QString::number(total * 1.0 / 1048576, 'f', 1) + " MB");
    }

    double percent = partial * 1.0 / total * 100;
    setCurrentTransferProgress(percent);
}

QString controller::currentTransferStats()
{
    return m_currentTransferStats;
}

void controller::setCurrentTransferStats(QString stats)
{
    if (stats == m_currentTransferStats)
        return;
    m_currentTransferStats = stats;
    emit currentTransferStatsChanged();
}

void controller::setBuddyName(QString name)
{
    m_settings->saveBuddyName(name.replace(' ', ""));
    m_duktoProtocol.updateBuddyName();
    m_buddyModel->updateMeElement();
    emit buddyNameChanged();
}

QString controller::buddyName()
{
    return m_settings->buddyName();
}

void controller::setBuddyAvatar(QString avatar)
{
    m_settings->saveBuddyAvatar(avatar);
    qDebug() << "controller::setBuddyAvatar:" << avatar;
    emit buddyAvatarChanged();
}

QString controller::buddyAvatar()
{
    if (m_settings->buddyAvatar() != "")
        return m_settings->buddyAvatar();
    return "images/user.png";
}

void controller::setThemeColor(QString color)
{
    m_settings->saveThemeColor(color);
    emit themeColorChanged();
}

QString controller::themeColor()
{
    return m_settings->themeColor();
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
        m_recentModel->addRecent(files->at(0), d.absoluteFilePath(files->at(0)), "file",
                m_currentTransferBuddy, totalSize);
    else
        m_recentModel->addRecent("Files and folders", d.absolutePath(), "misc",
                m_currentTransferBuddy, totalSize);

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
    QString pageText =
            "An error has occurred during the transfer... The data you received could be incomplete or broken.";
    emit gotoMessagePage(pageTitle, pageText);
    setCurrentTransferProgress(0);
}

QString controller::currentTransferBuddy()
{
    return m_currentTransferBuddy;
}

void controller::setCurrentTransferBuddy(QString buddy)
{
    if (buddy == m_currentTransferBuddy)
        return;
    m_currentTransferBuddy = buddy;
    emit currentTransferBuddyChanged();
}

QString controller::remoteDestinationAddress()
{
    return m_remoteDestinationAddress;
}

void controller::setRemoteDestinationAddress(QString address)
{
    if (address == m_remoteDestinationAddress)
        return;
    m_remoteDestinationAddress = address;
    emit remoteDestinationAddressChanged();
}

void controller::sendtext(QVariant indexPath, QString text)
{
    if (text == "")
        return;

    QVariantMap item = indexPath.toMap();
    m_destBuddy->fillFromItem(item);
    // Send text
    startTransfer(text);
}

void controller::receiveTextComplete(QString* text, qint64 totalSize)
{
//     Add an entry to recent activities
    m_recentModel->addRecent("Text snippet", *text, "text", m_currentTransferBuddy, totalSize);

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
    QString pageText = "Your data has been sent to your buddy!";
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
    QString pageText = "Sorry, an error has occurred while sending your data...\n\nError code: "
            + QString::number(code);
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
    QString ip = m_destBuddy->ip();
    qint16 port = m_destBuddy->port();
    if (!prepareStartTransfer(&ip, &port))
        return;

// Start files transfer
    m_duktoProtocol.sendText(ip, port, text);
}

bool controller::currentTransferSending()
{
    return m_currentTransferSending;
}

void controller::setCurrentTransferSending(bool sending)
{
    if (sending == m_currentTransferSending)
        return;
    m_currentTransferSending = sending;
    emit currentTransferSendingChanged();
}

void controller::abortTransfer()
{
    m_duktoProtocol.abortCurrentTransfer();
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

bool controller::showTermsOnStart()
{
    return m_settings->showTermsOnStart();
}

void controller::setShowTermsOnStart(bool showTerms)
{
    m_settings->saveShowTermsOnStart(showTerms);
    emit showTermsOnStartChanged();
}

QString controller::getHostName()
{
    return Platform::getHostname();
}
