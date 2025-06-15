/// Base exception for Overkiz errors.
abstract class BaseOverkizException implements Exception {
  const BaseOverkizException(this.message);

  final String message;

  @override
  String toString() => 'BaseOverkizException: $message';
}

/// Raised when an undefined error occurs while communicating with the Overkiz API.
class OverkizException extends BaseOverkizException {
  const OverkizException(super.message);

  @override
  String toString() => 'OverkizException: $message';
}

/// Raised when invalid credentials are provided.
class BadCredentialsException extends BaseOverkizException {
  const BadCredentialsException(super.message);

  @override
  String toString() => 'BadCredentialsException: $message';
}

/// Raised when an invalid command is provided.
class InvalidCommandException extends BaseOverkizException {
  const InvalidCommandException(super.message);

  @override
  String toString() => 'InvalidCommandException: $message';
}

/// Raised when an invalid API call is made.
class NoSuchResourceException extends BaseOverkizException {
  const NoSuchResourceException(super.message);

  @override
  String toString() => 'NoSuchResourceException: $message';
}

/// Raised when the user is not authenticated.
class NotAuthenticatedException extends BaseOverkizException {
  const NotAuthenticatedException(super.message);

  @override
  String toString() => 'NotAuthenticatedException: $message';
}

/// Raised when too many executions are requested.
class TooManyExecutionsException extends BaseOverkizException {
  const TooManyExecutionsException(super.message);

  @override
  String toString() => 'TooManyExecutionsException: $message';
}

/// Raised when the execution queue is full.
class ExecutionQueueFullException extends BaseOverkizException {
  const ExecutionQueueFullException(super.message);

  @override
  String toString() => 'ExecutionQueueFullException: $message';
}

/// Raised when too many requests are made.
class TooManyRequestsException extends BaseOverkizException {
  const TooManyRequestsException(super.message);

  @override
  String toString() => 'TooManyRequestsException: $message';
}

/// Raised when too many concurrent requests are made.
class TooManyConcurrentRequestsException extends BaseOverkizException {
  const TooManyConcurrentRequestsException(super.message);

  @override
  String toString() => 'TooManyConcurrentRequestsException: $message';
}

/// Raised when the service is unavailable.
class ServiceUnavailableException extends BaseOverkizException {
  const ServiceUnavailableException(super.message);

  @override
  String toString() => 'ServiceUnavailableException: $message';
}

/// Raised when the service is under maintenance.
class MaintenanceException extends ServiceUnavailableException {
  const MaintenanceException(super.message);

  @override
  String toString() => 'MaintenanceException: $message';
}

/// Raised when the authorization token is missing.
class MissingAuthorizationTokenException extends BaseOverkizException {
  const MissingAuthorizationTokenException(super.message);

  @override
  String toString() => 'MissingAuthorizationTokenException: $message';
}

/// Raised when an invalid event listener ID is provided.
class InvalidEventListenerIdException extends BaseOverkizException {
  const InvalidEventListenerIdException(super.message);

  @override
  String toString() => 'InvalidEventListenerIdException: $message';
}

/// Raised when no event listener is registered.
class NoRegisteredEventListenerException extends BaseOverkizException {
  const NoRegisteredEventListenerException(super.message);

  @override
  String toString() => 'NoRegisteredEventListenerException: $message';
}

/// Raised when both session and bearer are provided in the same request.
class SessionAndBearerInSameRequestException extends BaseOverkizException {
  const SessionAndBearerInSameRequestException(super.message);

  @override
  String toString() => 'SessionAndBearerInSameRequestException: $message';
}

/// Raised when too many attempts are made and the user is (temporarily) banned.
class TooManyAttemptsBannedException extends BaseOverkizException {
  const TooManyAttemptsBannedException(super.message);

  @override
  String toString() => 'TooManyAttemptsBannedException: $message';
}

/// Raised when an invalid token is provided.
class InvalidTokenException extends BaseOverkizException {
  const InvalidTokenException(super.message);

  @override
  String toString() => 'InvalidTokenException: $message';
}

/// Raised when an invalid token is provided.
class NotSuchTokenException extends BaseOverkizException {
  const NotSuchTokenException(super.message);

  @override
  String toString() => 'NotSuchTokenException: $message';
}

/// Raised when an unknown user is provided.
class UnknownUserException extends BaseOverkizException {
  const UnknownUserException(super.message);

  @override
  String toString() => 'UnknownUserException: $message';
}

/// Raised when an unknown object is provided.
class UnknownObjectException extends BaseOverkizException {
  const UnknownObjectException(super.message);

  @override
  String toString() => 'UnknownObjectException: $message';
}

/// Raised when access is denied to the gateway. This often happens when the user is not the owner of the gateway.
class AccessDeniedToGatewayException extends BaseOverkizException {
  const AccessDeniedToGatewayException(super.message);

  @override
  String toString() => 'AccessDeniedToGatewayException: $message';
}

// Nexity specific exceptions

/// Raised when invalid credentials are provided to Nexity authentication API.
class NexityBadCredentialsException extends BadCredentialsException {
  const NexityBadCredentialsException(super.message);

  @override
  String toString() => 'NexityBadCredentialsException: $message';
}

/// Raised when an error occurs while communicating with the Nexity API.
class NexityServiceException extends BaseOverkizException {
  const NexityServiceException(super.message);

  @override
  String toString() => 'NexityServiceException: $message';
}

// CozyTouch specific exceptions

/// Raised when invalid credentials are provided to CozyTouch authentication API.
class CozyTouchBadCredentialsException extends BadCredentialsException {
  const CozyTouchBadCredentialsException(super.message);

  @override
  String toString() => 'CozyTouchBadCredentialsException: $message';
}

/// Raised when an error occurs while communicating with the CozyTouch API.
class CozyTouchServiceException extends BaseOverkizException {
  const CozyTouchServiceException(super.message);

  @override
  String toString() => 'CozyTouchServiceException: $message';
}

// Somfy specific exceptions

/// Raised when invalid credentials are provided to Somfy authentication API.
class SomfyBadCredentialsException extends BadCredentialsException {
  const SomfyBadCredentialsException(super.message);

  @override
  String toString() => 'SomfyBadCredentialsException: $message';
}

/// Raised when an error occurs while communicating with the Somfy API.
class SomfyServiceException extends BaseOverkizException {
  const SomfyServiceException(super.message);

  @override
  String toString() => 'SomfyServiceException: $message';
}